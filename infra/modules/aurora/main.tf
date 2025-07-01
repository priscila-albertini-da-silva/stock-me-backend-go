resource "aws_rds_cluster" "aurora" {
  cluster_identifier     = "aurora-postgres-cluster"
  engine                 = "aurora-postgresql"
  engine_version         = "15.3"
  master_username        = "admin"
  master_password        = "secret"
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.aurora_sg.id]
  database_name          = "stockme"
}

resource "aws_rds_cluster_instance" "aurora_instance" {
  count              = 1
  identifier         = "aurora-postgres-instance-${count.index}"
  cluster_identifier = aws_rds_cluster.aurora.id
  instance_class     = "db.r6g.large"
  engine             = aws_rds_cluster.aurora.engine
  engine_version     = aws_rds_cluster.aurora.engine_version
}

resource "aws_security_group" "aurora_sg" {
  name        = "aurora-postgres-sg"
  description = "Permite acesso ao Aurora PostgreSQL"
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
