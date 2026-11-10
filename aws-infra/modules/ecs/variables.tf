variable "cluster_name" {
  type    = string
  default = "2048"
}

variable "family_name" {
  type    = string
  default = "2048"
}

variable "requires_compatibilities" {
  type    = list(string)
  default = ["FARGATE"]
}

variable "network_mode" {
  type    = string
  default = "awsvpc"
}

variable "taskexecution_role_arn" {
  type = string
}

variable "task_cpu" {
  type    = number
  default = 256
}

variable "task_memory" {
  type    = number
  default = 512
}

variable "container_name" {
  type    = string
  default = "2048"
}

variable "container_image" {
  type    = string
  default = "public.ecr.aws/nginx/nginx:1.31.7-arm64v8"
}

variable "container_cpu" {
  type    = number
  default = 256
}

variable "container_memory" {
  type    = number
  default = 512
}

variable "essential" {
  type    = bool
  default = true
}

variable "container_port" {
  type    = number
  default = 8080
}

variable "container_host_port" {
  type    = number
  default = 8080
}

variable "service_name" {
  type    = string
  default = "2048"
}

variable "launch_type" {
  type    = string
  default = "FARGATE"
}

variable "assign_public_ip" {
  type    = bool
  default = false
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "health_check_grace_period_seconds" {
  type    = number
  default = 120
}



variable "target_group_arn" {
  type = string

}

variable "ecs_sg" {
  type = string

}

variable "subnets" {
  type = list(string)

}

variable "log_group_name" {
  type    = string
  default = "/ecs/2048"
}

variable "log_stream_prefix" {
  type    = string
  default = "2048"
}

variable "aws_region" {
  type    = string
  default = "eu-west-2"
}

variable "deployment_maximum_percent" {
  type    = number
  default = 200
}

variable "deployment_minimum_healthy_percent" {
  type    = number
  default = 100
}

variable "availability_zone_rebalancing" {
  type    = string
  default = "ENABLED"
}

