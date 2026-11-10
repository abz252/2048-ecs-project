variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr1" {
  description = "CIDR block for first public subnet"
  type        = string
  default     = "10.0.0.0/24"
}

variable "private_subnet_cidr1" {
  description = "CIDR block for first private subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_cidr2" {
  description = "CIDR block for second public subnet"
  type        = string
  default     = "10.0.10.0/24"
}

variable "private_subnet_cidr2" {
  description = "CIDR block for second private subnet"
  type        = string
  default     = "10.0.11.0/24"
}

variable "map_public_ip_on_launch" {
  description = "Whether to map public IP on launch for private subnets"
  type        = bool
  default     = false
}

variable "public_route_cidr_block" {
  description = "CIDR block for public route"
  type        = string
  default     = "0.0.0.0/0"
}

variable "private_route_cidr_block" {
  description = "CIDR block for private route"
  type        = string
  default     = "0.0.0.0/0"
}

variable "domain" {
  description = "Domain for the EIP"
  type        = string
  default     = "vpc"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}