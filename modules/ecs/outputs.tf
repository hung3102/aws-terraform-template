output "cluster_name" {
  value = aws_ecs_cluster.api.name
}

output "service_name" {
  value = aws_ecs_service.api.name
}
