resource "aws_vpc" "eks_vpc" {
  cidr_block = "10.0.0.0/16"
}

# Create a subnet
resource "aws_subnet" "eks_subnet" {
  cidr_block = "10.0.1.0/24"
  vpc_id     = aws_vpc.eks_vpc.id
}
