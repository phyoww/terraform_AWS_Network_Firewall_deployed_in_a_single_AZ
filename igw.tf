resource "aws_internet_gateway" "cloudideastar_ig" {
  vpc_id = aws_vpc.cloudideastar_vpc.id

  tags = {
    Name = "Cloudideastar Internet Gateway"
  }
}


### Internet Gateway route table
resource "aws_route_table" "igw" {
  vpc_id = aws_vpc.cloudideastar_vpc.id

  route {
    cidr_block      = "10.0.101.0/24"   #aws_subnet.cloudideastar_public_subnet.id
    vpc_endpoint_id = (aws_networkfirewall_firewall.NFW.firewall_status[0].sync_states[*].attachment[0].endpoint_id)[0]
  }

  tags = {
    Name = "Internet Gateway Route Table"
  }
}
resource "aws_route_table_association" "igw" {
  depends_on = [
    aws_route_table.igw
   ]
  gateway_id     = aws_internet_gateway.cloudideastar_ig.id
  route_table_id = aws_route_table.igw.id
}

