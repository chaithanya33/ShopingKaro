resource "aws_s3_bucket" "env_file" {
  bucket = var.project_name
  tags = merge(local.common_tags, { Name = "${var.project_name}" })
}

resource "aws_s3_object" "env_file" {
  bucket = aws_s3_bucket.env_file.id
  key    = "env_file.env"
}