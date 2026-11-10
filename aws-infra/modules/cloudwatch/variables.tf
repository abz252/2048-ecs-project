variable "load_balancer_suffix_arn" {
  type = string

}

variable "region" {
  type    = string
  default = "eu-west-2"

}

variable "service_name" {
  type = string

}

variable "cluster_name" {
  type = string

}

variable "log_group_name" {
  type    = string
  default = "/ecs/2048"

}

variable "retention_days" {
  type    = string
  default = 7

}

variable "log_stream_name" {
  type    = string
  default = "2048"

}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "alarm_name" {
  type    = string
  default = "2048-cpu"

}

variable "comparison_operator" {
  type    = string
  default = "GreaterThanOrEqualToThreshold"

}

variable "evaluation_period" {
  type    = string
  default = 2

}

variable "metric_name" {
  type    = string
  default = "CPUUtilization"

}


variable "namespace" {
  type    = string
  default = "AWS/ECS"

}

variable "period" {
  type    = string
  default = 300

}

variable "threshold" {
  type    = string
  default = 80

}

variable "statistic" {
  type    = string
  default = "Average"

}

variable "alarm_description" {
  type    = string
  default = "This metric monitors ecs cpu utilization"

}
