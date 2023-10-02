
# Ref => https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
resource "random_string" "bucket_name" {
  length   = 16
  lower    = true
  upper    = false
  special  = false
}

# Terraform AWS S3 bucket => https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
# S3 Bucket Naming rule => https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html
resource "aws_s3_bucket" "example" {
  bucket = random_string.bucket_name.result

  tags={
    UserUuid= var.user_uuid
  }
}



