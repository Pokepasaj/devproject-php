resource "aws_subnet" "my-subnet-php" {
  vpc_id     = aws_vpc.my-subnet-php.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "my-subnet-php"
  }
}