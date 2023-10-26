data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_network_interface" "main" {
  subnet_id   = aws_subnet.my-subnet-php.id
  private_ips = ["10.0.1.5"]

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "web" {
  ami = data.aws_ami.amzn-linux-2023-ami.id
  instance_type = "t2.micro"

   network_interface {
    network_interface_id = aws_network_interface.main.id
    device_index         = 0
  }

  tags = {
    Name = "terraform-ec2"
  }
}