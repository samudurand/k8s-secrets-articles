module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.33.1"

  cluster_name    = "eks-cluster"
  cluster_version = "1.32"

  vpc_id  = aws_vpc.eks_vpc.id
  
  subnet_ids = [
    aws_subnet.eks_subnet_1.id, 
    aws_subnet.eks_subnet_2.id
  ]

  cluster_endpoint_public_access = true
  # Allows the user creating the cluster to access it
  enable_cluster_creator_admin_permissions = true

  # Creates an OpenID Connect Provider for EKS to enable IRSA (IAM Roles for K8s Service Accounts)
  enable_irsa = true

  # Enable envelope encryption for Kubernetes secrets using AWS KMS
  cluster_encryption_config = {
    provider_key_arn = aws_kms_key.eks_secrets.arn
    resources        = ["secrets"]
  }

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

# KMS key for EKS secrets encryption
resource "aws_kms_key" "eks_secrets" {
  description             = "KMS key for EKS secrets encryption"
  deletion_window_in_days = 7
  enable_key_rotation     = true
}

# Good practice for KMS keys management
resource "aws_kms_alias" "eks_secrets" {
  name          = "alias/eks-secrets"
  target_key_id = aws_kms_key.eks_secrets.key_id
}



