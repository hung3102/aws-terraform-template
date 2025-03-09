# output "nat_eip_id" {
#   value = aws_eip.nat.id
# }

output "bastion_host_eip_id" {
  value = aws_eip.bastion_host.id
}
