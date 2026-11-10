resource "aws_security_group" "alb" {
  name        = var.alb_sg_name
  description = var.alb_sg_description
  vpc_id      = var.vpc_id
  tags        = var.tags
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.alb.id
  cidr_ipv4         = var.alb_sg_ingress_rule_cidr_ipv4
  from_port         = var.alb_sg_ingress_rule_from_port
  ip_protocol       = var.alb_sg_ingress_rule_ip_protocol
  to_port           = var.alb_sg_ingress_rule_to_port
  tags              = var.tags
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.alb.id
  cidr_ipv4         = var.alb_sg_egress_rule_cidr_ipv4
  ip_protocol       = var.alb_sg_egress_rule_ip_protocol 
  tags              = var.tags
}


resource "aws_security_group" "ecs" {
  name        = var.ecs_sg_name
  description = var.ecs_sg_description
  vpc_id      = var.vpc_id
  tags        = var.tags
}

resource "aws_vpc_security_group_ingress_rule" "allow_ecs_http" {
  security_group_id            = aws_security_group.ecs.id
  referenced_security_group_id = aws_security_group.alb.id
  from_port                    = var.ecs_sg_ingress_rule_from_port
  ip_protocol                  = var.ecs_sg_ingress_rule_ip_protocol
  to_port                      = var.ecs_sg_ingress_rule_to_port
  tags                         = var.tags
}

resource "aws_vpc_security_group_egress_rule" "allow_all_ecs_traffic_ipv4" {
  security_group_id = aws_security_group.ecs.id
  cidr_ipv4         = var.ecs_sg_egress_rule_cidr_ipv4
  ip_protocol       = var.ecs_sg_egress_rule_ip_protocol 
  tags              = var.tags
}




