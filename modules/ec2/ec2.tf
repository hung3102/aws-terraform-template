data "aws_ami" "bastion_ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "architecture"
    values = ["arm64"]
  }
  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }
}

resource "aws_instance" "bastion_host" {
  ami                    = data.aws_ami.bastion_ami.id
  instance_type          = var.bastion_host_instance_type
  subnet_id              = var.public_subnet_ids[0]
  vpc_security_group_ids = var.bastion_host_security_group_ids

  tags = {
    Name = "${var.prefix}-bastion"
  }
}

// fix ip address
resource "aws_eip_association" "bastion_eip_assoc" {
  instance_id   = aws_instance.bastion_host.id
  allocation_id = var.bastion_host_eip_id
}
