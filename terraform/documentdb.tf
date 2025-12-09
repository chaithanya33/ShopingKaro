resource "aws_docdb_subnet_group" "docdb_sg" {
  name       = "${var.project_name}-docdb-subnet-group"
  subnet_ids = var.private_subnet_ids
  tags       = { Name = "${var.project_name}-docdb-subnet-group" }
}

resource "aws_security_group" "docdb_sg" {
  name   = "${var.project_name}-docdb-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port       = 27017
    to_port         = 27017
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_docdb_cluster" "cluster" {
  cluster_identifier     = "${var.project_name}-docdb-cluster"
  master_username        = var.docdb_username
  master_password        = var.docdb_password
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.docdb_sg.id]
}

resource "aws_docdb_cluster_instance" "instance" {
  count              = 1
  identifier         = "${var.project_name}-docdb-instance-${count.index}"
  cluster_identifier = aws_docdb_cluster.cluster.id
  instance_class     = "db.t3.medium"
  engine             = "docdb"
}
