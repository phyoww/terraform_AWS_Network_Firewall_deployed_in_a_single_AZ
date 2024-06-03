resource "aws_subnet" "cloudideastar_public_subnet" {
  vpc_id            = aws_vpc.cloudideastar_vpc.id
  cidr_block        = "10.0.101.0/24"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "Cloudideastar Public Subnet"
  }
}

resource "aws_subnet" "cloudideastar_private_subnet" {
  vpc_id            = aws_vpc.cloudideastar_vpc.id
  cidr_block        = "10.0.201.0/24"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "Cloudideastar Private Subnet"
  }
}


resource "aws_subnet" "cloudideastar_firewall_subnet" {
  vpc_id            = aws_vpc.cloudideastar_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "Cloudideastar Firewall Subnet"
  }
}
