resource "aws_subnet" "public-1" {
  cidr_block                          = "10.0.32.0/20"
  map_public_ip_on_launch             = true
  private_dns_hostname_type_on_launch = "ip-name"
  availability_zone                   = "ap-northeast-1a"

  tags = {
    Name = "${var.prefix}-public-1"
  }

  tags_all = {
    Name = "${var.prefix}-public-1"
  }

  vpc_id = var.vpc_id
}

resource "aws_subnet" "public-2" {
  cidr_block                          = "10.0.64.0/20"
  map_public_ip_on_launch             = true
  private_dns_hostname_type_on_launch = "ip-name"
  availability_zone                   = "ap-northeast-1c"

  tags = {
    Name = "${var.prefix}-public-2"
  }

  tags_all = {
    Name = "${var.prefix}-public-2"
  }

  vpc_id = var.vpc_id
}

resource "aws_subnet" "private-1" {
  cidr_block                          = "10.0.0.0/20"
  map_public_ip_on_launch             = false
  private_dns_hostname_type_on_launch = "ip-name"
  availability_zone                   = "ap-northeast-1a"

  tags = {
    Name = "${var.prefix}-private-1"
  }

  tags_all = {
    Name = "${var.prefix}-private-1"
  }

  vpc_id = var.vpc_id
}

resource "aws_subnet" "private-2" {
  cidr_block                          = "10.0.16.0/20"
  map_public_ip_on_launch             = false
  private_dns_hostname_type_on_launch = "ip-name"
  availability_zone                   = "ap-northeast-1c"

  tags = {
    Name = "${var.prefix}-private-2"
  }

  tags_all = {
    Name = "${var.prefix}-private-2"
  }

  vpc_id = var.vpc_id
}
