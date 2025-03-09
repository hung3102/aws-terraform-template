output "bastion_host_network_interface_id" {
  value = aws_instance.bastion_host.primary_network_interface_id
}
