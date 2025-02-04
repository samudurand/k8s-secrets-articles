module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.33.1"

  cluster_name    = "eks-cluster"
  cluster_version = "1.32" # Latest EKS version as of my knowledge cutoff

  vpc_id  = aws_vpc.eks_vpc.id
  
  subnet_ids = [
    aws_subnet.eks_subnet_1.id, 
    aws_subnet.eks_subnet_2.id
  ]

  # Enable public access to the cluster endpoint
  cluster_endpoint_public_access = true
  # Allows the user creating the cluster to access it
  enable_cluster_creator_admin_permissions = true

  eks_managed_node_groups = {
    default = {
      min_size     = 1
      max_size     = 1
      desired_size = 1

      instance_types = ["t3.small"]
      capacity_type  = "ON_DEMAND"
    }
  }
}

