data "tls_certificate" "github" {
  url = var.certificate_url

}

resource "aws_iam_openid_connect_provider" "default" {
  url = var.oidc_provider_url

  client_id_list = [
    var.client_id
  ]
  thumbprint_list = [data.tls_certificate.github.certificates[0].sha1_fingerprint]

}

data "aws_iam_policy_document" "github_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.default.arn]
    }

    condition {
      test     = "StringEquals"
      variable = var.variable_aud
      values   = var.variable_aud_values
    }

    condition {
      test     = "StringEquals"
      variable = var.variable_sub
      values   = var.variable_sub_values
    }
  }

}

resource "aws_iam_role" "github_trust" {
  name               = var.github_role_name
  assume_role_policy = data.aws_iam_policy_document.github_role_policy.json

}

data "aws_iam_policy_document" "github_permission_policy" {
  statement {
    sid    = "AllowVPCActions"
    effect = "Allow"
    actions = [

      #vpc actions

      "ec2:CreateVpc",
      "ec2:DeleteVpc",
      "ec2:DescribeVpcs",
      "ec2:DescribeAvailabilityZones",
      "ec2:DescribeVpcAttribute",
      "ec2:ModifyVpcAttribute",

      #subnet actions

      "ec2:CreateSubnet",
      "ec2:DeleteSubnet",
      "ec2:DescribeSubnets",
      "ec2:ModifySubnetAttribute",
      #route table actions
      "ec2:AssociateRouteTable",
      "ec2:DisassociateRouteTable",
      "ec2:CreateRoute",
      "ec2:CreateRouteTable",
      "ec2:DeleteRoute",
      "ec2:DeleteRouteTable",
      "ec2:DescribeRouteTables",

      #igw actions
      "ec2:AttachInternetGateway",
      "ec2:DetachInternetGateway",
      "ec2:CreateInternetGateway",
      "ec2:DeleteInternetGateway",
      "ec2:DescribeInternetGateways",

      #nat gateway actions

      "ec2:CreateNatGateway",
      "ec2:DeleteNatGateway",
      "ec2:DescribeNatGateways",
      #security group actions

      "ec2:AuthorizeSecurityGroupEgress",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:RevokeSecurityGroupEgress",
      "ec2:RevokeSecurityGroupIngress",
      "ec2:CreateSecurityGroup",
      "ec2:DeleteSecurityGroup",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSecurityGroupRules",

      #elastic ip actions
      "ec2:AllocateAddress",
      "ec2:ReleaseAddress",
      "ec2:AssociateAddress",
      "ec2:DisassociateAddress",
      "ec2:DescribeAddresses",
      "ec2:CreateTags",
      "ec2:DeleteTags",
      "ec2:DescribeTags",
      "ec2:DescribeAddressesAttribute",

      #network interface actions

      "ec2:DescribeNetworkInterfaces",
      "ec2:AttachNetworkInterface",
      "ec2:DetachNetworkInterface",
    ]
    resources = ["*"]
  }

  statement {
    sid    = "AllowALBActions"
    effect = "Allow"
    actions = [
      "elasticloadbalancing:AddListenerCertificates",
      "elasticloadbalancing:AddTags",
      "elasticloadbalancing:CreateListener",
      "elasticloadbalancing:CreateLoadBalancer",
      "elasticloadbalancing:CreateRule",
      "elasticloadbalancing:CreateTargetGroup",
      "elasticloadbalancing:DeleteListener",
      "elasticloadbalancing:DeleteLoadBalancer",
      "elasticloadbalancing:DeleteRule",
      "elasticloadbalancing:DeleteTargetGroup",
      "elasticloadbalancing:DeregisterTargets",
      "elasticloadbalancing:RegisterTargets",
      "elasticloadbalancing:RemoveListenerCertificates",
      "elasticloadbalancing:RemoveTags",
      "elasticloadbalancing:SetIpAddressType",
      "elasticloadbalancing:SetSecurityGroups",
      "elasticloadbalancing:SetSubnets",
      "elasticloadbalancing:DescribeLoadBalancers",
      "elasticloadbalancing:DescribeListeners",
      "elasticloadbalancing:DescribeRules",
      "elasticloadbalancing:DescribeSSLPolicies",
      "elasticloadbalancing:DescribeTags",
      "elasticloadbalancing:DescribeTargetGroups",
      "elasticloadbalancing:DescribeTargetHealth",
      "elasticloadbalancing:DescribeLoadBalancerAttributes",
      "elasticloadbalancing:DescribeListenerCertificates",
      "elasticloadbalancing:DescribeTargetGroupAttributes",
      "elasticloadbalancing:ModifyLoadBalancerAttributes",
      "elasticloadbalancing:ModifyTargetGroupAttributes",
      "elasticloadbalancing:DescribeListenerAttributes",

    ]
    resources = ["*"]
  }

  statement {
    sid    = "AllowIAMActions"
    effect = "Allow"
    actions = [
      "iam:AttachRolePolicy",
      "iam:CreatePolicy",
      "iam:CreateRole",
      "iam:DeleteRole",
      "iam:DeleteRolePolicy",
      "iam:GetPolicy",
      "iam:PassRole",
      "iam:PutRolePolicy",
      "iam:GetRolePolicy",
      "iam:ListPolicies",
      "iam:ListAttachedRolePolicies",
      "iam:ListRolePolicies",
      "iam:TagRole",
      "iam:UntagRole",
      "iam:ListRoleTags",
      "iam:GetRole",
      "iam:ListRoles",
      "iam:ListInstanceProfilesForRole",
      "iam:DetachRolePolicy"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "AllowRoute53Actions"
    effect = "Allow"
    actions = [

      "route53:ChangeResourceRecordSets",
      "route53:ListResourceRecordSets",
      "route53:ListHostedZones",
      "route53:GetHostedZone",
      "route53:ChangeTagsForResource",
      "route53:ListTagsForResource",
      "route53:ListTagsForResources",
      "route53:GetChange",


    ]

    resources = ["*"]
  }
  statement {
    sid    = "AllowACMActions"
    effect = "Allow"
    actions = [
      "acm:RequestCertificate",
      "acm:DescribeCertificate",
      "acm:ListCertificates",
      "acm:DeleteCertificate",
      "acm:AddTagsToCertificate",
      "acm:RemoveTagsFromCertificate",
      "acm:ListTagsForCertificate",


    ]
    resources = ["*"]
  }

  statement {
    sid    = "AllowCloudwatchActions"
    effect = "Allow"
    actions = [
      "cloudwatch:DeleteAlarms",
      "cloudwatch:DeleteDashboards",
      "cloudwatch:DescribeAlarms",
      "cloudwatch:PutDashboard",
      "cloudwatch:ListDashboards",
      "cloudwatch:PutMetricAlarm",
      "cloudwatch:ListMetrics",
      "cloudwatch:TagResource",
      "cloudwatch:UntagResource",
      "cloudwatch:ListTagsForResource",
      "cloudwatch:GetDashboard",
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    sid    = "AllowCloudwatchLogActions"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DeleteLogGroup",
      "logs:DescribeLogGroups",
      "logs:PutRetentionPolicy",
      "logs:DeleteLogStream",
      "logs:PutQueryDefinition",
      "logs:DeleteQueryDefinition",
      "logs:DescribeQueryDefinitions",
      "logs:TagResource",
      "logs:ListTagsForResource",

    ]
    resources = ["*"]
  }


  statement {
    sid    = "AllowECRActions"
    effect = "Allow"
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:CompleteLayerUpload",
      "ecr:CreateRepository",
      "ecr:DescribeRepositories",
      "ecr:DeleteRepository",
      "ecr:GetAuthorizationToken",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart",
      "ecr:TagResource",
      "ecr:UntagResource",
      "ecr:ListTagsForResource",
      "ecr:BatchGetImage",
      "ecr:BatchDeleteImage",


    ]
    resources = ["*"]
  }


  statement {
    sid    = "AllowECSActions"
    effect = "Allow"
    actions = [
      "ecs:CreateCluster",
      "ecs:ListClusters",
      "ecs:CreateService",
      "ecs:ListServices",
      "ecs:RegisterTaskDefinition",
      "ecs:ListTaskDefinitions",
      "ecs:DeleteCluster",
      "ecs:DeleteService",
      "ecs:DeregisterTaskDefinition",
      "ecs:DescribeClusters",
      "ecs:DescribeServices",
      "ecs:DescribeTaskDefinition",
      "ecs:DescribeTasks",
      "ecs:UpdateService",
      "ecs:TagResource",
      "ecs:UntagResource",
      "ecs:ListTagsForResource",

    ]
    resources = ["*"]
  }
  statement {
    sid    = "AllowS3Actions"
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:DeleteObject",
    ]
    resources = ["${aws_s3_bucket.ecs_terraform_state.arn}/*"]
  }

}

resource "aws_iam_role_policy" "permission-attach" {
  role   = aws_iam_role.github_trust.name
  policy = data.aws_iam_policy_document.github_permission_policy.json
}
