output "bucket_name"{
   description = "Bucket name for our static website"
   value = module.home_toyland_hosting.bucket_name
}

output "s3_website_endpoint"{
   description = "S3 static website hosting endpoint"
   value = module.home_toyland_hosting.website_endpoint
}

output "domain_name"{
   description = "Cloudfront distribution domain name"
   value = module.home_toyland_hosting.domain_name
}