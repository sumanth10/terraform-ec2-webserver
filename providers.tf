terraform {
  backend "local" {
    path = "./terraform.tfstate" # Path to store the state file locally
  }
}

provider "aws" {
  region = "eu-central-1"

#  We can add assume_role parameter to make TF assume a role (much safer if we are trying to automate the deployment process) and a session name to identify in AWS
# We can add some default tag that would be injected every resource (For eg: cost-center, env etc)
}