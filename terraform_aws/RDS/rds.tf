
resource "aws_db_instance" "rds_company" {
  engine                  = "postgres"
  engine_version          = "14.7"
  instance_class          = "db.t3.medium"
  db_name                 = "my_db"
  identifier              = "rds-company"
  username                = "my_username"
  password                = jsondecode(nonsensitive(data.aws_secretsmanager_secret_version.current.secret_string))["company_database"]
  allocated_storage       = 20
  storage_type            = "gp2"
  vpc_security_group_ids  = [var.rds_company]
  skip_final_snapshot     = true
  apply_immediately       = true
  db_subnet_group_name    = aws_db_subnet_group.rds_company.name
  parameter_group_name    = aws_db_parameter_group.rds-company.name
  publicly_accessible     = true
  storage_encrypted       = true
  multi_az                = true
  backup_retention_period = 7
}

data "aws_secretsmanager_secret" "database_vars" {
  name = "db_vars"
}

data "aws_secretsmanager_secret_version" "current" {
  secret_id = data.aws_secretsmanager_secret.database_vars.id
}

resource "aws_db_parameter_group" "rds-company" {
  name   = "rds-company"
  family = "postgres14"
}

resource "aws_db_subnet_group" "rds_company" {
  name       = "rds_company"
  subnet_ids = [var.public_subnet_id_a,var.public_subnet_id_b]
}


