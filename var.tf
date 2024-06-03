variable "firewall-name" {
  type    = string
  default = "Cloudideastar-aws-network-firewall"
}

variable "aws_region" {
  type    = string
  default = "ap-southeast-1"
}

variable "cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "http-domains-to-deny" {
  type    = list(any)
  default = ["test.example.com"]
}
variable "https-domains-to-deny" {
  type    = list(any)
  default = ["test.example.com"]
}


variable "cloudwatch-log-group-name" {
  type    = string
  default = "test-aws-network-firewall"
}

variable "ami-id" {
  type    = string
  default = "ami-04d29b6f966df1537"
}

variable "instance-type" {
  type    = string
  default = "t2.micro"
}

# variable "fqdn_lambda_nfw_arn" {
#    type = string
#    default = "Network-Firewall-Resolver-Function"
# }