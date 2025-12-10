resource "aws_ecr_repository" "app" {
  name                 = var.project_name
  image_tag_mutability = "MUTABLE"
  force_delete         = true
  tags                 = merge(local.common_tags, { Name = "${var.project_name}-ecr" })
}
