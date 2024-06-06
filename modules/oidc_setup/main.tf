
locals {
  circleci_oidc_url = "oidc.circleci.com/org/59d58a9e-1d8e-4430-b31f-df1ad3abc3d7"
  assume_role_value = "org/59d58a9e-1d8e-4430-b31f-df1ad3abc3d7/project/26d11f32-fded-45c1-915e-cd8023f53d27/user/*"
}

# Identity Provider
resource "aws_iam_openid_connect_provider" "circleci" {
  url = "https://${local.circleci_oidc_url}"

  client_id_list = [
    var.circleci_org_id,
  ]

  thumbprint_list = [for thumbprint in var.thumbprints : thumbprint]
}


# Role's permissions
data "aws_iam_policy_document" "circleci" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.circleci.arn]
    }

    condition {
      test     = "StringLike"
      variable = "${local.circleci_oidc_url}:sub"
      values   = [local.assume_role_value]
    }
  }
}

# Trusted role for Web Identity
resource "aws_iam_role" "circleci" {
  name               = "CircleCI_OIDC"
  assume_role_policy = data.aws_iam_policy_document.circleci.json
}

# Allow ECR pull/push for the role
resource "aws_iam_role_policy" "circleci" {
  name = "circleci_oidc_ecr"
  role = aws_iam_role.circleci.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchCheckLayerAvailability",
          "ecr:DescribeImages",
          "ecr:DescribeRepositories",
          "ecr:GetDownloadUrlForLayer",
          "ecr:ListImages",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}