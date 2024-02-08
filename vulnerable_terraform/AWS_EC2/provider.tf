provider "aws" {
  region                   = var.AWS_REGION
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "default"
}

