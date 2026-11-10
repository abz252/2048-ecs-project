variable "route53_zone_name" {
  description = "The name of the Route 53 zone"
  type        = string
  default     = "abz252.com"
}

variable "subdomain" {
  description = "The subdomain for the Route 53 record"
  type        = string
  default     = "ecs-project"
}

variable "record_type" {
  description = "The type of the Route 53 record"
  type        = string
  default     = "A"
}

variable "alb_dns_name" {
  description = "The DNS name of the ALB to point the Route 53 record to"
  type        = string
  default     = ""
}

variable "alb_zone_id" {
  description = "The zone ID of the ALB to point the Route 53 record to"
  type        = string
  default     = ""
}

variable "validation_method" {
  description = "The validation method for the ACM certificate"
  type        = string
  default     = "DNS"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}

}
    