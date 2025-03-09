# TODO: remove nat ip
resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_eip" "bastion_host" {
  domain = "vpc"
}
