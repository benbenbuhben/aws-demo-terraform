resource "aws_ssm_parameter" "db_host" {
  name  = "/ihme-demo-app/DB_HOST"
  type  = "SecureString"
  value = var.db_host
}

resource "aws_ssm_parameter" "db_user" {
  name  = "/ihme-demo-app/DB_USER"
  type  = "SecureString"
  value = var.db_user
}

resource "aws_ssm_parameter" "db_password" {
  name  = "/ihme-demo-app/DB_PASSWORD"
  type  = "SecureString"
  value = var.db_password
}

resource "aws_ssm_parameter" "db_name" {
  name  = "/ihme-demo-app/DB_NAME"
  type  = "SecureString"
  value = var.db_name
}

resource "aws_ssm_parameter" "docker_username" {
  name  = "/ihme-demo-app/DOCKER_USERNAME"
  type  = "SecureString"
  value = var.docker_username
}

resource "aws_ssm_parameter" "docker_password" {
  name  = "/ihme-demo-app/DOCKER_PASSWORD"
  type  = "SecureString"
  value = var.docker_password
}
