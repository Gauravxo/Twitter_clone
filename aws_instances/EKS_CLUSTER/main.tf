provider "aws" {
  region = "ca-central-1"
}

# -------------------------
# VPC and Networking
# -------------------------
resource "aws_vpc" "kxo_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "kxo-vpc"
  }
}

resource "aws_subnet" "kxo_subnet" {
  count                     = 2
  vpc_id                    = aws_vpc.kxo_vpc.id
  cidr_block                = cidrsubnet(aws_vpc.kxo_vpc.cidr_block, 8, count.index)
  availability_zone         = element(["ca-central-1a", "ca-central-1b"], count.index)
  map_public_ip_on_launch   = true  # ✅ Fix: ensures EC2 nodes get public IPs
  tags = {
    Name = "kxo-subnet-${count.index}"
  }
}

resource "aws_internet_gateway" "kxo_igw" {
  vpc_id = aws_vpc.kxo_vpc.id
  tags = {
    Name = "kxo-igw"
  }
}

resource "aws_route_table" "kxo_route_table" {
  vpc_id = aws_vpc.kxo_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.kxo_igw.id
  }

  tags = {
    Name = "kxo-route-table"
  }
}

resource "aws_route_table_association" "kxo_route_table_association" {
  count          = 2
  subnet_id      = aws_subnet.kxo_subnet[count.index].id
  route_table_id = aws_route_table.kxo_route_table.id
}

# -------------------------
# Security Groups
# -------------------------
resource "aws_security_group" "kxo_cluster_sg" {
  vpc_id      = aws_vpc.kxo_vpc.id
  description = "EKS cluster communication"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "kxo-cluster-sg"
  }
}

resource "aws_security_group" "kxo_node_sg" {
  vpc_id      = aws_vpc.kxo_vpc.id
  description = "EKS node group communication"

  ingress {
    from_port       = 1025
    to_port         = 65535
    protocol        = "tcp"
    security_groups = [aws_security_group.kxo_cluster_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "kxo-node-sg"
  }
}

# -------------------------
# IAM Roles
# -------------------------
resource "aws_iam_role" "kxo_cluster_role" {
  name = "kxo-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "eks.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role" "kxo_node_group_role" {
  name = "kxo-node-group-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

# -------------------------
# IAM Policy Attachments
# -------------------------
resource "aws_iam_role_policy_attachment" "kxo_cluster_role_policy" {
  role       = aws_iam_role.kxo_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "kxo_node_group_role_policy" {
  role       = aws_iam_role.kxo_node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "kxo_node_group_cni_policy" {
  role       = aws_iam_role.kxo_node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "kxo_node_group_registry_policy" {
  role       = aws_iam_role.kxo_node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

# -------------------------
# EKS Cluster
# -------------------------
resource "aws_eks_cluster" "kxo" {
  name     = "kxo-cluster"
  role_arn = aws_iam_role.kxo_cluster_role.arn

  vpc_config {
    subnet_ids         = aws_subnet.kxo_subnet[*].id
    security_group_ids = [aws_security_group.kxo_cluster_sg.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.kxo_cluster_role_policy
  ]
}

# -------------------------
# EKS Node Group
# -------------------------
resource "aws_eks_node_group" "kxo" {
  cluster_name    = aws_eks_cluster.kxo.name
  node_group_name = "kxo-node-group"
  node_role_arn   = aws_iam_role.kxo_node_group_role.arn
  subnet_ids      = aws_subnet.kxo_subnet[*].id

  scaling_config {
    desired_size = 3
    max_size     = 3
    min_size     = 3
  }

  instance_types = ["t2.large"]

  depends_on = [
    aws_iam_role_policy_attachment.kxo_node_group_role_policy,
    aws_iam_role_policy_attachment.kxo_node_group_cni_policy,
    aws_iam_role_policy_attachment.kxo_node_group_registry_policy
  ]
}

