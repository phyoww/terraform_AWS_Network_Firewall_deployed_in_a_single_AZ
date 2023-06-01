resource "aws_vpc" "cloudideastar_custom_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Cloudideastar Custom VPC"
  }
}
