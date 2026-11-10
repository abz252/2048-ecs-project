variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "repo_name" {
  description = "Name of the ECR repository"
  type        = string
  default     = "myapp/2048"
}

variable "image_tag_mutability" {
  description = "Image tag mutability setting for the ECR repository"
  type        = string
  default     = "IMMUTABLE"
}