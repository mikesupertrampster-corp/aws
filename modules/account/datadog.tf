terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
    }
  }
}

data "datadog_ip_ranges" "source" {}

resource "aws_security_group_rule" "datadog" {
  security_group_id = aws_security_group.lb.id
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = data.datadog_ip_ranges.source.synthetics_ipv4
  type              = "ingress"
}
