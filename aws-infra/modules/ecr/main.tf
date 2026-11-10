resource "aws_ecr_repository" "game_2048" {
  name                 = var.repo_name
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = true
  }

  force_delete = true
  tags         = var.tags
}
