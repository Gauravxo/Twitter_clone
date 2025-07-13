output "cluster_id" {
  value = aws_eks_cluster.kxo.id
}

output "node_group_id" {
  value = aws_eks_node_group.kxo.id
}

output "vpc_id" {
  value = aws_vpc.kxo_vpc.id
}

output "subnet_ids" {
  value = aws_subnet.kxo_subnet[*].id
}
