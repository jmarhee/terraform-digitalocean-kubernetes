terraform {
  backend "s3" {
    api_endpoint                    = "nyc3.digitaloceanspaces.com"
    region                      = "us-west-1"
    key                         = "terraform.tfstate"
    skip_requesting_account_id  = true
    skip_credentials_validation = true
    skip_get_ec2_platforms      = true
    skip_metadata_api_check     = true
  }
}

provider "digitalocean" {
  token = "${var.digitalocean_token}"
}

module "kube_token_1" {
  source = "./modules/kube-token"
}
