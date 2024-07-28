terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.19.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
  profile = "company"
}



terraform {
  backend "s3" {
    bucket = "company-s3"
    key = "company/terraform.tfstate"
    region = "eu-west-1"
    encrypt = true
    dynamodb_table = "terraform-locks"
    profile = "company"
  }
}

#Modules
module "VPC" {
  source = "./VPC"
}

module "SecurityGroup" {
  source = "./SecurityGroup"
  public_subnet_id_a = module.VPC.public-eu-west-1a-id
  public_subnet_id_b = module.VPC.public-eu-west-1b-id
  private_subnet_id_a = module.VPC.private-eu-west-1a-id
  private_subnet_id_b = module.VPC.private-eu-west-1b-id
  vpc_id = module.VPC.vpc_id
}

# module "RDS" {
#   source = "./RDS"
#   public_subnet_id_a = module.VPC.public-eu-west-1a-id
#   public_subnet_id_b = module.VPC.public-eu-west-1b-id
#   private_subnet_id_a = module.VPC.private-eu-west-1a-id
#   private_subnet_id_b = module.VPC.private-eu-west-1b-id
#   vpc_id = module.VPC.vpc_id
#   rds_company = module.SecurityGroup.rds_company
# }

# module "EC2" {
#   source = "./EC2"
#   public_subnet_id_a = module.VPC.public-eu-west-1a-id
#   public_subnet_id_b = module.VPC.public-eu-west-1b-id
#   private_subnet_id_a = module.VPC.private-eu-west-1a-id
#   private_subnet_id_b = module.VPC.private-eu-west-1b-id
#   vpc_id = module.VPC.vpc_id
#   ssh-access = module.SecurityGroup.ssh-access
# }

# module "S3" {
#   source = "./S3"
# }

module "EKS" {
  source = "./EKS"
  public_subnet_id_a = module.VPC.public-eu-west-1a-id
  public_subnet_id_b = module.VPC.public-eu-west-1b-id
  private_subnet_id_a = module.VPC.private-eu-west-1a-id
  private_subnet_id_b = module.VPC.private-eu-west-1b-id
  id_vpc = module.VPC.vpc_id
}


/*module "Cloudfront" {
    source =  "./Cloudfront"
    environment = terraform.workspace
    projectname =  "Cloudfront"
}*/


