variable "alb_name" {
  type    = string
  default = "alb"
}

variable "internal" {
  type    = bool
  default = false
}

variable "load_balancer_type" {
  type    = string
  default = "application"
}

variable "aws_security_group_alb_id" {
  type = string
}

variable "public_subnets_ids" {
  type = list(string)

}

variable "tg_name" {
  type    = string
  default = "alb-ip-tg"
}

variable "tg_port" {
  type    = number
  default = 8080
}

variable "tg_protocol" {
  type    = string
  default = "HTTP"
}

variable "tg_target_type" {
  type    = string
  default = "ip"
}

variable "healthy_threshold" {
  type    = number
  default = 2
}

variable "health_check_interval" {
  type    = number
  default = 15
}

variable "health_check_matcher" {
  type    = string
  default = "200"
}

variable "health_check_path" {
  type    = string
  default = "/"
}

variable "health_check_timeout" {
  type    = number
  default = 10
}

variable "vpc_id" {
  type = string

}

variable "listener_port" {
  type    = number
  default = 443
}

variable "listener_protocol" {
  type    = string
  default = "HTTPS"
}

variable "listener_protocol_type" {
  type    = string
  default = "forward"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "acm_validation_arn" {
  description = "ARN of the ACM certificate for HTTPS validation"
  type        = string
}

variable "listener_ssl_policy" {
  description = "SSL policy for the ALB listener"
  type        = string
  default     = "ELBSecurityPolicy-TLS13-1-0-PQ-2025-09"
}