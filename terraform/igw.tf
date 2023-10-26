resource "aws_internet_gateway" "my-igw-php" {
  vpc_id = aws_vpc.vpc-php.id
}