terraform {
  #backend "remote"{
  # hostname="app.terraform.io"
  # organization= "Ncodes"  
     
  #    workspaces{
  #      name="terra-house-ncodes"
  #    }
  #}
  
  #cloud {
  #  organization = "Ncodes"
#
  #  workspaces {
  #    name = "terra-house-ncodes"
  #  }
  #}
  
}

module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}





