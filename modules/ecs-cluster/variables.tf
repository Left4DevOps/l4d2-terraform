variable "name" {
  type    = string
  default = "left4devops"
}

variable "key_name" {
  description = "Key pair for remote access"
  type        = string
}

variable "aws_region" {
  type = string
}

variable "log_retention" {
  description = "Days logs kept"
  type        = number
  default     = 7
}

variable "volume_size" {
  description = "Volume size in GB"
  type        = number
  default     = 30
}

variable "vpc_id" {
  description = "Which VPC to use, if not specified, use the first one we find"
  type        = string
  default     = ""
}

variable "subnets" {
  description = "Which subnet within the VPC to deploy to, if not specified, uses all"
  type        = list(string)
  default     = []
}