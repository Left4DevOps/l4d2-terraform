resource "aws_security_group_rule" "rcon" {
  description       = "${local.name} RCON"
  security_group_id = var.security_group
  type              = "ingress"
  protocol          = "tcp"
  from_port         = var.port
  to_port           = var.port
  cidr_blocks       = [local.public_cidr]
}

resource "aws_security_group_rule" "gameplay" {
  description       = "${local.name} Gameplay"
  security_group_id = var.security_group
  type              = "ingress"
  protocol          = "udp"
  from_port         = var.port
  to_port           = var.port
  cidr_blocks       = [local.public_cidr]
}

resource "aws_security_group_rule" "netcon" {
  count             = local.net_con_port > 0 ? 1 : 0
  description       = "${local.name} NetCON"
  security_group_id = var.security_group
  type              = "ingress"
  protocol          = "tcp" //TODO: test me
  from_port         = local.net_con_port
  to_port           = local.net_con_port
  cidr_blocks       = [var.trusted_cidr]
}