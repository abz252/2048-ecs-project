variable "taskexecution_role_name" {
  type    = string
  default = "taskexecution_role"

}

variable "assume_role_policy_action" {
  type    = string
  default = "sts:AssumeRole"
}

variable "assume_role_policy_effect" {
  type    = string
  default = "Allow"
}

variable "assume_role_policy_principal_service" {
  type    = string
  default = "ecs-tasks.amazonaws.com"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}

}
