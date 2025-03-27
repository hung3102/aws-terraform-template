resource "aws_instance" "bastion_host" {
  ami                    = "ami-05506fa68391b4cb1"
  instance_type          = var.bastion_host_instance_type
  subnet_id              = var.public_subnet_ids[0]
  vpc_security_group_ids = var.bastion_host_security_group_ids
  iam_instance_profile   = aws_iam_instance_profile.bastion_host_profile.name
  source_dest_check      = false

  # Enable NAT functionality
  user_data = <<-EOF
    #!/bin/bash
    sudo yum install iptables-services -y
    sudo systemctl enable iptables
    sudo systemctl start iptables

    # Enable IP forwarding
    echo "net.ipv4.ip_forward = 1" | sudo tee -a /etc/sysctl.d/custom-ip-forwarding.conf
    sudo sysctl -p /etc/sysctl.d/custom-ip-forwarding.conf

    # Enable NAT
    netstat -i
    sudo /sbin/iptables -t nat -A POSTROUTING -o enX0 -j MASQUERADE
    sudo /sbin/iptables -F FORWARD
    sudo service iptables save
  EOF

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
