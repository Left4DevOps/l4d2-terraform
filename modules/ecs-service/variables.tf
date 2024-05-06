variable "aws_region" {
  type = string
}

variable "cluster" {
  description = "Name of ECS cluster task will run from"
  type        = string
}

variable "log_group_name" {
  description = "Name of log group"
  type        = string
}

variable "security_group" {
  description = "Security Group to open game port on cluster"
  type        = string
}

variable "trusted_cidr" {
  description = "CIDR range for NetCon admin"
  type        = string
}

variable "cpu" {
  description = "CPU units to reserve for game, 1024 is a whole core"
  type        = number
  default     = 1024
}

variable "memory" {
  description = "MB of RAM to allocate to service, 1GB should work for vanilla gameplay in any mode"
  type        = number
  default     = 1024
}

variable "registry" {
  description = "Use to specify an alternate registy if using your own images"
  type        = string
  default     = "left4devops"
}

variable "game" {
  description = "l4d or l4d2"
  type        = string
  default     = "l4d2"
}

variable "docker_tag" {
  description = "Used to specify an alternative image"
  type        = string
  default     = "latest"
}

variable "addon_path" {
  description = "Change addon directory on host"
  type        = string
  default     = ""
}

//Environment:
variable "hostname" {
  description = "Name displayed in Server Browser"
  type        = string
  default     = "Left4DevOps"
}

variable "region" {
  description = "Steam region for matchmaking"
  type        = number
  default     = 255
}

variable "steam_group" {
  description = "ID of Steam Group"
  type        = number
  default     = 0
}

variable "steam_group_exclusive" {
  description = "set to true to limit users to group members"
  type        = bool
  default     = false
}

variable "port" {
  description = "Game Port"
  type        = number
  default     = 27015
}

variable "default_mode" {
  type    = string
  default = "coop"
}

variable "rcon_password" {
  type      = string
  default   = ""
  sensitive = true
}

variable "net_con_diff" {
  type    = number
  default = 0
}

variable "net_con_port" {
  type    = number
  default = 0
}

variable "net_con_password" {
  type      = string
  default   = ""
  sensitive = true
}

variable "extra_args" {
  type    = string
  default = ""
}