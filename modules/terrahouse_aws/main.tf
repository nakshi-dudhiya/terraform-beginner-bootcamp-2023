terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.19.0"
    }
  }
}

#For Random Ref => https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string

# Terraform AWS S3 bucket => https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
# S3 Bucket Naming rule => https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html
resource "aws_s3_bucket" "website_bucket" {
  bucket = var.bucket_name

  tags={
    UserUuid= var.user_uuid
  }
}