terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "5.48.0"
        }
    }
backend "s3" {

    bucket = "terraform-s3-buckets-ec2" 
    key = "expense-dev-vpc"
    region = "us-east-1"
    dynamodb_table = "daws78s-lock"
 }
}
provider "aws" {
    region = "us-east-1"
}

