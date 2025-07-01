resource "aws_db_instance" "postgres" {
  identifier              = "rds-postgres-instance"
  allocated_storage       = 20
  engine                  = "postgres"
  engine_version          = "15.3"
  instance_class          = "db.t3.micro" # ou db.t2.micro (free tier)
  username                = "priscila"
  password                = "prisecret"
  db_name                 = "stockme"
  vpc_security_group_ids  = [aws_security_group.postgres_sg.id]
  skip_final_snapshot     = true
  publicly_accessible     = false # true se quiser acessar fora da VPC
  storage_type            = "gp2"
  backup_retention_period = 7
}

resource "aws_security_group" "postgres_sg" {
  name        = "postgres-sg"
  description = "Permite acesso ao PostgreSQL"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["172.31.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
