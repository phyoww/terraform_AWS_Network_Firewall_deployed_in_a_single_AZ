locals {
  region = var.aws_region


  stateful_ip_rules_data           = csvdecode(file("${path.module}/files/stateful/ip-rules.csv"))
  stateful_https_domains_list_data = file("${path.module}/files/stateful/https-domains-list.csv")
  stateful_http_domains_list_data  = file("${path.module}/files/stateful/http-domains-list.csv")

  stateless_ip_rules_data = csvdecode(file("${path.module}/files/stateless/ip-rules.csv"))
}