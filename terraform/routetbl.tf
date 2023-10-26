resource "aws_route_table" "my-routtab-php" {
  vpc_id = aws_vpc.vpc-php.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw-php.id
  }

  tags = {
    Name = "my-routtab-php"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.foo.id
  route_table_id = aws_route_table.bar.id
}

