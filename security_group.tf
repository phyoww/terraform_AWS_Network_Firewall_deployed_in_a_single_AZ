resource "aws_security_group" "securitygroup" {
  name        = "CloudideastarSecurityGroup"
  description = "CloudideastarSecurityGroup"
  vpc_id      = aws_vpc.cloudideastar_vpc.id
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  ingress {
    description = "Allow all ICMP - IPv4 traffic"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
  }
  ingress {
    description = "Allow HTTP "
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
  tags = {
    "Name" = "CloudideastarSecurityGroup"
  }
}