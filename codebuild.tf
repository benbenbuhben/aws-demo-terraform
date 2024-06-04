resource "aws_codebuild_project" "demo_app_1" {
  name         = "demo-app-1-build"
  service_role = aws_iam_role.codebuild_service_role.arn
  source {
    type      = "GITHUB"
    location  = "https://github.com/benbenbuhben/aws-demo-app-1.git"
    buildspec = "buildspec.yml"
  }
  artifacts {
    type = "NO_ARTIFACTS"
  }
  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:4.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true
    environment_variable {
      name  = "REPOSITORY_URI"
      value = aws_ecr_repository.demo_app.repository_url
    }
  }
}

resource "aws_codebuild_project" "demo_app_2" {
  name         = "demo-app-2-build"
  service_role = aws_iam_role.codebuild_service_role.arn
  source {
    type      = "GITHUB"
    location  = "https://github.com/benbenbuhben/aws-demo-app-2.git"
    buildspec = "buildspec.yml"
  }
  artifacts {
    type = "NO_ARTIFACTS"
  }
  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:4.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true
    environment_variable {
      name  = "REPOSITORY_URI"
      value = aws_ecr_repository.demo_app.repository_url
    }
  }
}
