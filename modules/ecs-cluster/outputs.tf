output "cluster_name" {
  value = aws_ecs_cluster.app.name
}

output "log_group_name" {
  value = aws_cloudwatch_log_group.app.name
}

output "security_group_id" {
  value = aws_security_group.app.id
}