resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.cloudideastar_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    #    gateway_id = aws_internet_gateway.cloudideastar_ig.id
    vpc_endpoint_id = (aws_networkfirewall_firewall.NFW.firewall_status[0].sync_states[*].attachment[0].endpoint_id)[0]
  }

  tags = {
    Name = "Public Route Table"
  }
}
resource "aws_route_table_association" "public_1_rt_a" {
  subnet_id      = aws_subnet.cloudideastar_public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}
