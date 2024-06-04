variable "db_host" {
  description = "Database host"
  type        = string
  sensitive   = true
}

variable "db_user" {
  description = "Database user"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Database name"
  type        = string
  sensitive   = true
}

variable "docker_username" {
  description = "Docker username"
  type        = string
  sensitive   = true
}

variable "docker_password" {
  description = "Docker password"
  type        = string
  sensitive   = true
}

variable "github_token" {
  description = "OAuth token for GitHub"
  type        = string
  sensitive   = true
}
