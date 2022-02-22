terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}


provider "aws" {
  region = var.DeploymentRegion
  assume_role {
    role_arn     = "arn:aws:iam::DATA TO BE PROVIDED"
    session_name = "Teradmin-hub-session"
  }
}


provider "aws" {
  region = var.DeploymentRegion
  alias  = "spoke"
  assume_role {
    role_arn     = "arn:aws:iam::DATA TO BE PROVIDED"
    session_name = "Teradmin-spoke-session"
  }
}
