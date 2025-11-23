terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.21.0"
    }
  }
  backend "s3" {
    bucket = "qttfstatenov25"
    key = "projects/muliregion/aws"
    region = "us-west-2"
    use_lockfile = true
    
  }
}

provider "aws" {
  alias  = "primary"
  region = "us-west-2"
}

provider "aws" {
  alias  = "secondary"
  region = "us-east-1"

}