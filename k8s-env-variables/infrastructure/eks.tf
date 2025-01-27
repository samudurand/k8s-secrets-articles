module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.33.1"

  cluster_name    = "eks-cluster"
  cluster_version = "1.32" # Latest EKS version as of my knowledge cutoff

  vpc_id  = aws_vpc.eks_vpc.id
  subnet_ids = [aws_subnet.eks_subnet.id]

  fargate_profiles = {
    default = {
      name = "default"
      selectors = [
        {
          namespace = "default"
        }
      ]
    }
  }     
}

