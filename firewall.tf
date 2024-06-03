##########################################

resource "aws_networkfirewall_firewall_policy" "policy" {
  name = "cloudideastar-aws-network-firewall-policy" #"${var.project_name}-firewall-policy-${var.environment}"
  firewall_policy {
    stateless_default_actions          = ["aws:forward_to_sfe"]
    stateless_fragment_default_actions = ["aws:forward_to_sfe"]

    stateless_rule_group_reference {
      priority     = 1
      resource_arn = aws_networkfirewall_rule_group.stateless-ip-rules.arn
    }

    # Stateful configuration
    stateful_engine_options {
      rule_order = "STRICT_ORDER"
    }
    stateful_default_actions = ["aws:drop_strict", "aws:alert_strict", "aws:alert_established"]

    stateful_rule_group_reference {
      priority     = 10
      resource_arn = aws_networkfirewall_rule_group.stateful-ip-rules.arn
    }

    stateful_rule_group_reference {
      priority     = 20
      resource_arn = aws_networkfirewall_rule_group.https-fw-rule.arn
    }

    # stateful_rule_group_reference {
    #   priority     = 30
    #   resource_arn = var.fqdn_lambda_nfw_arn
    # }    

  }

  tags = {
    Name = "cloudideastar-aws-network-firewall-policy"
  }
}

resource "aws_networkfirewall_firewall" "NFW" {
  firewall_policy_arn = aws_networkfirewall_firewall_policy.policy.arn
  name                = var.firewall-name #"${var.project_name}-${var.environment}"
  vpc_id              = aws_vpc.cloudideastar_vpc.id
  subnet_mapping {
    subnet_id = aws_subnet.cloudideastar_firewall_subnet.id
  }
  tags = {
    Name = "Cloudideastar-aws-network-firewall"
  }
}

