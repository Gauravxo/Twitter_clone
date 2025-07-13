# Key Pair
resource "aws_key_pair" "id_rsa" {
  key_name   = "id_rsa"
  public_key = file("~/.ssh/id_rsa.pub")
}

# Security Group
resource "aws_security_group" "kxo_security" {
  name        = "ci-cd-security-group"
  description = "Security group for CI/CD servers"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instances
resource "aws_instance" "kxo_instance" {
  for_each = {
    "sonarqube" = { size = "t2.medium", script = "sonarqube.sh" },
    "nexus"     = { size = "t2.medium", script = "nexus.sh" },
    "jenkins"   = { size = "t2.large",  script = "jenkins.sh" }
  }

  ami             = "ami-0f9cb75652314425a"  # Amazon Linux 2023
  instance_type   = each.value.size
  key_name        = aws_key_pair.id_rsa.key_name
  security_groups = [aws_security_group.kxo_security.name]
  user_data       = file(each.value.script)

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }

  tags = {
    Name = each.key
  }
}
