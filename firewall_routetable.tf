### Firewall route table
resource "aws_route_table" "FW" {
  vpc_id = aws_vpc.cloudideastar_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cloudideastar_ig.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.cloudideastar_ig.id
  }

  tags = {
    Name = "Cloudideastar Firewall Route Table"
  }
}
resource "aws_route_table_association" "fw" {

  subnet_id      = aws_subnet.cloudideastar_firewall_subnet.id
  route_table_id = aws_route_table.FW.id
}

