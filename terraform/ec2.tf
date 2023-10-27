data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_network_interface" "main" {
  subnet_id   = aws_subnet.main.id
  private_ips = ["10.0.1.5"]
}

resource "aws_instance" "main" {
  ami = data.aws_ami.amzn-linux-2023-ami.id
  instance_type = "t2.micro"
  associate_public_ip_address = true
}