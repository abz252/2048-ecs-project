variable "alb_sg_name" {
  description = "Name of the ALB security group"
  type        = string
  default     = "alb_sg"
}

variable "alb_sg_description" {
  description = "Description of the ALB security group"
  type        = string
  default     = "Allow https inbound traffic and all outbound traffic"
}

variable "alb_sg_ingress_rule_cidr_ipv4" {
  description = "CIDR block for the ALB security group ingress rule"
  type        = string
  default     = "0.0.0.0/0"
}

variable "alb_sg_ingress_rule_from_port" {
  description = "From port for the ALB security group ingress rule"
  type        = number
  default     = 443
}

variable "alb_sg_ingress_rule_ip_protocol" {
  description = "IP protocol for the ALB security group ingress rule"
  type        = string
  default     = "tcp"
}

variable "alb_sg_ingress_rule_to_port" {
  description = "To port for the ALB security group ingress rule"
  type        = number
  default     = 443
}

variable "alb_sg_egress_rule_cidr_ipv4" {
  description = "CIDR block for the ALB security group egress rule"
  type        = string
  default     = "0.0.0.0/0"

}

variable "alb_sg_egress_rule_ip_protocol" {
  description = "IP protocol for the ALB security group egress rule"
  type        = string
  default     = "-1" # semantically equivalent to all ports
}

variable "ecs_sg_name" {
  description = "Name of the ECS security group"
  type        = string
  default     = "ecs_sg"
}

variable "ecs_sg_description" {
  description = "Description of the ECS security group"
  type        = string
  default     = "Allow http inbound traffic and all outbound traffic from alb "
}

variable "ecs_sg_ingress_rule_from_port" {
  description = "From port for the ECS security group ingress rule"
  type        = number
  default     = 8080
}

variable "ecs_sg_ingress_rule_ip_protocol" {
  description = "IP protocol for the ECS security group ingress rule"
  type        = string
  default     = "tcp"
}

variable "ecs_sg_ingress_rule_to_port" {
  description = "To port for the ECS security group ingress rule"
  type        = number
  default     = 8080
}

variable "ecs_sg_egress_rule_cidr_ipv4" {
  description = "CIDR block for the ECS security group egress rule"
  type        = string
  default     = "0.0.0.0/0"
}

variable "ecs_sg_egress_rule_ip_protocol" {
  description = "IP protocol for the ECS security group egress rule"
  type        = string
  default     = "-1" # semantically equivalent to all ports
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}