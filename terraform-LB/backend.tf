terraform {
  required_providers {
           aws = {
              source = "hashicorp/aws"
              version = "5.1.0"
 
}
}

backend "s3" {

 bucket = "terraform-production-infra"
 key = "production-state.tf"
 region = "ap-northeast-1"
 dynamodb_table = "state-db"
   
}

}

provider "aws" {
 region = "ap-northeast-1"
}
