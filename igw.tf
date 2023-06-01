resource "aws_internet_gateway" "cloudideastar_ig" {
  vpc_id = aws_vpc.cloudideastar_custom_vpc.id

  tags = {
    Name = "Cloudideastar Internet Gateway"
  }
}
