####################################################
resource "aws_networkfirewall_rule_group" "stateless-ip-rules" {
  name     = "cloudideastar-stateless-ip-rule-group-lab"
  capacity = 100
  type     = "STATELESS"

  rule_group {
    rules_source {
      stateless_rules_and_custom_actions {
        dynamic "stateless_rule" {
          for_each = local.stateless_ip_rules_data
          content {
            priority = stateless_rule.value.priority
            rule_definition {
              actions = ["aws:${stateless_rule.value.action}"]
              match_attributes {
                protocols = [stateless_rule.value.protocol]
                source {
                  address_definition = stateless_rule.value.source
                }
                destination {
                  address_definition = stateless_rule.value.destination
                }
              }
            }
          }
        }
      }
    }
  }

  tags = {
    Name = "cloudideastar-stateless-ip-rule-group-lab"
  }
}

resource "aws_networkfirewall_rule_group" "https-fw-rule" {
  capacity = 1500
  name     = "cloudideastar-https-fw-rule-group-lab"
  type     = "STATEFUL"
  rule_group {
    rules_source {
      rules_source_list {
        generated_rules_type = "ALLOWLIST"
        target_types         = ["HTTP_HOST", "TLS_SNI"]
        targets = [
          for line in split("\n", local.stateful_https_domains_list_data) : trim(line, " \r")
        ]
      }
    }
    stateful_rule_options {
      rule_order = "STRICT_ORDER"
    }
  }

  tags = {
    Name = "cloudideastar-https-fw-rule-group-lab"
  }
}

resource "aws_networkfirewall_rule_group" "stateful-ip-rules" {
  capacity = 1500
  name     = "cloudideastar-stateful-ip-fw-rule-group-lab"
  type     = "STATEFUL"
  rule_group {
    rules_source {
      dynamic "stateful_rule" {
        for_each = local.stateful_ip_rules_data
        content {
          action = stateful_rule.value.action
          header {
            destination      = stateful_rule.value.destination
            destination_port = stateful_rule.value.destination_port
            direction        = "ANY"
            protocol         = stateful_rule.value.protocol
            source           = stateful_rule.value.source
            source_port      = stateful_rule.value.source_port
          }
          rule_option {
            keyword  = "sid"
            settings = [stateful_rule.key + 1]
          }
        }
      }
    }
    stateful_rule_options {
      rule_order = "STRICT_ORDER"
    }
  }

  tags = {
    Name = "cloudideastar-stateful-ip-fw-rule-group-lab"
  }
}
