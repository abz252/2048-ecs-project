
resource "aws_s3_bucket" "ecs_terraform_state" {
  bucket        = "practise-ecs-tf-statefile"
  force_destroy = true

  lifecycle {
    prevent_destroy = false
  }


}

resource "aws_s3_bucket_server_side_encryption_configuration" "ecs_terraform_state" {
  bucket = aws_s3_bucket.ecs_terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "ecs_terraform_state" {
  bucket = aws_s3_bucket.ecs_terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "allow_access_for_oidc" {
  bucket = aws_s3_bucket.ecs_terraform_state.id
  policy = data.aws_iam_policy_document.allow_access_for_oidc.json
}

data "aws_iam_policy_document" "allow_access_for_oidc" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::942548380779:role/github_role"]
    }

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:ListBucket",
      "s3:DeleteObject",
    ]

    resources = [
      aws_s3_bucket.ecs_terraform_state.arn,
      "${aws_s3_bucket.ecs_terraform_state.arn}/*",
    ]
  }
}
