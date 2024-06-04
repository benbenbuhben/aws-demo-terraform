resource "aws_iam_role" "codebuild_service_role" {
  name = "codebuild_service_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "codebuild.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      },
      {
        Effect = "Allow",
        Principal = {
          AWS = "arn:aws:iam::992382508838:role/codebuild_service_role"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach the AmazonEC2ContainerRegistryPowerUser policy to the CodeBuild role
resource "aws_iam_role_policy_attachment" "codebuild_attach" {
  role       = aws_iam_role.codebuild_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}

# Define the IAM role for CodePipeline
resource "aws_iam_role" "codepipeline_service_role" {
  name = "codepipeline_service_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "codepipeline.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Define policy for CloudWatch Logs permissions for CodeBuild
resource "aws_iam_role_policy" "codebuild_logs_policy" {
  name = "codebuild_logs_policy"
  role = aws_iam_role.codebuild_service_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}

# Attach full access policies for CodePipeline
resource "aws_iam_role_policy_attachment" "codepipeline_attach" {
  role       = aws_iam_role.codepipeline_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodePipeline_FullAccess"
}

# Attach S3 full access policy to the CodePipeline role
resource "aws_iam_role_policy_attachment" "codepipeline_s3_attach" {
  role       = aws_iam_role.codepipeline_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

# Attach CodeBuild developer access policy to the CodePipeline role
resource "aws_iam_role_policy_attachment" "codepipeline_codebuild_attach" {
  role       = aws_iam_role.codepipeline_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess"
}

# Define policy for S3 access permissions for CodeBuild
resource "aws_iam_role_policy" "codebuild_s3_policy" {
  name = "codebuild_s3_policy"
  role = aws_iam_role.codebuild_service_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:PutObject"
        ],
        Resource = [
          "arn:aws:s3:::ihme-codepipeline-artifacts-bucket/*"
        ]
      }
    ]
  })
}

# Define policy for EKS DescribeCluster permission for CodeBuild
resource "aws_iam_role_policy" "codebuild_eks_policy" {
  name = "codebuild_eks_policy"
  role = aws_iam_role.codebuild_service_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "eks:DescribeCluster"
        ],
        Resource = "arn:aws:eks:us-east-1:992382508838:cluster/ihme-demo-cluster"
      }
    ]
  })
}

# Define policy for SSM Parameter Store access for CodeBuild
resource "aws_iam_role_policy" "codebuild_ssm_policy" {
  name = "codebuild_ssm_policy"
  role = aws_iam_role.codebuild_service_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ssm:GetParameter",
          "ssm:GetParameters",
          "ssm:GetParametersByPath"
        ],
        Resource = "arn:aws:ssm:us-east-1:992382508838:parameter/ihme-demo-app/*"
      }
    ]
  })
}

resource "aws_iam_role_policy" "codebuild_eks_permissions" {
  name = "codebuild_eks_permissions"
  role = aws_iam_role.codebuild_service_role.id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "eks:DescribeCluster",
          "eks:ListClusters",
          "eks:DescribeNodegroup",
          "eks:ListNodegroups",
          "eks:DescribeFargateProfile",
          "eks:ListFargateProfiles"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "sts:AssumeRole"
        ],
        "Resource" : "arn:aws:iam::992382508838:role/codebuild_service_role"
      }
    ]
    }
  )
}

resource "aws_iam_role_policy" "codebuild_assume_role_policy" {
  name = "codebuild_assume_role_policy"
  role = aws_iam_role.codebuild_service_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "sts:AssumeRole",
        Resource = "arn:aws:iam::992382508838:role/codebuild_service_role"
      }
    ]
  })
}
