terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {}

# Define common tags to be added to all resources
locals {
  common_tags = {
    Project = "TF-Cadabra",
    CreatedBy = var.name_initials
  }
}