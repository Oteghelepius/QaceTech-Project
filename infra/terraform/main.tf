provider "aws" {
  region = "eu-north-1"
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "~> 20.0" 
  cluster_name    = "sinatra-cluster"
  cluster_version = "1.27"
  enable_irsa     = true

  vpc_id  = "vpc-xxx"  
  subnet_ids = ["subnet-xxx", "subnet-yyy"]  

  eks_managed_node_groups = {
    default = {
      instance_types = ["t3.medium"]
      min_size       = 1
      max_size       = 3
      desired_size   = 2
    }
  }

  tags = {
    Environment = "main"
    Project     = "sinatra-cats"
  }
}
