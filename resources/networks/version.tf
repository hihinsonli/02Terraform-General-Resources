terraform {
  # Terraform version constraint: https://www.terraform.io/language/settings#specifying-a-required-terraform-version
  required_version = ">= 1.2.7, < 2.0.0"

  # Providers & version:
  required_providers {
    # AWS provider & version constraint: https://registry.terraform.io/providers/hashicorp/aws/latest
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.93.0"
    }

    backend "s3" {
      bucket         = "my-web-app-terraform-state-bjzfrkwnm"
      key            = "network/terraform.tfstate"
      region         = "ap-southeast-2"
      dynamodb_table = "my-web-app-terraform-locks"
    }
  }
}