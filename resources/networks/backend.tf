terraform {
  backend "s3" {
    bucket         = "my-web-app-terraform-state-bjzfrkwnm"
    key            = "network/terraform.tfstate"
    region         = "ap-southeast-2"
    dynamodb_table = "my-web-app-terraform-locks"
  }
}
