terraform {
  required_providers {
     terratowns = {
	source = "local.providers/local/terratowns"
        version = "1.0.0"
     }
  }
  #backend "remote"{
  # hostname="app.terraform.io"
  # organization= "Ncodes"  
     
  #    workspaces{
  #      name="terra-house-ncodes"
  #    }
  #}
  
  cloud {
    organization = "Ncodes"
    workspaces {
      name = "terra-house-ncodes"
    }
  }

}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
} 

module "home_toyland_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.toyland.public_path
  content_version = var.toyland.content_version
}

resource "terratowns_home" "home" {
  name = "Lego-Toyland!!"
  description = <<DESCRIPTION
A town made of toys where we play all day
DESCRIPTION
  domain_name = module.home_toyland_hosting.domain_name
  town = "gamers-grotto"
  content_version = var.toyland.content_version
}

module "home_camping_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.camping.public_path
  content_version = var.camping.content_version
}

resource "terratowns_home" "myhome" {
  name= "Life is better around the Campfire!"
  description= <<DESCRIPTION
Camping is a timeless outdoor adventure that brings people closer to nature and allows them to disconnect from the hustle and bustle of modern life.
Whether it's in a remote wilderness, a tranquil forest, or a bustling campground, the experience of setting up tents, kindling a campfire, 
and sleeping under the starry sky instills a sense of simplicity and self-reliance.
DESCRIPTION
  domain_name = module.home_camping_hosting.domain_name
  town = "the-nomad-pad"
  content_version = var.camping.content_version
}




