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
  iam_instance_profile   = aws_iam_instance_profile.bastion_host_profile.name

  tags = {
    Name = "${var.prefix}-bastion"
  }
}


resource "aws_iam_instance_profile" "bastion_host_profile" {
  name = "${var.prefix}-bastion-host-profile"
  role = var.bastion_host_role_name
}

// fix ip address
resource "aws_eip_association" "bastion_eip_assoc" {
  instance_id   = aws_instance.bastion_host.id
  allocation_id = var.bastion_host_eip_id
}
