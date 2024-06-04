resource "aws_s3_bucket" "ihme_codepipeline_bucket" {
  bucket = "ihme-codepipeline-artifacts-bucket"
}
