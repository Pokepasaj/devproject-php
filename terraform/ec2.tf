resource "aws_network_interface" "main" {
  subnet_id   = aws_subnet.main.id
  private_ips = ["10.0.1.5"]
}

resource "aws_launch_configuration" "main" {
  name          = "main"
  image_id      = "ami-0fd6dfc993d1322c7"
  instance_type = "t2.micro"

  associate_public_ip_address = true

  security_groups = [aws_security_group.main.id]

  lifecycle {
    create_before_destroy = true
  }

  user_data = <<-EOF
#!/bin/bash

# Install Docker
sudo yum update -y
sudo amazon-linux-extras install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user

# Install Apache (httpd)
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/v2.3.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Verify The Installation
docker-compose version

# Create directories for MongoDB, MySQL, and PHP App
mkdir /home/ec2-user/php
mkdir /home/ec2-user/mysql
mkdir /home/ec2-user/mongodb
#chown -R ec2-user:ec2-user php/ mongodb/ mysql/ -> change owner of the dirs in order to add all required files without sudo
EOF

}
resource "aws_autoscaling_group" "main" {
  desired_capacity  = 2
  max_size          = 4
  min_size          = 1
  health_check_type = "ELB"

  launch_configuration = aws_launch_configuration.main.name
  vpc_zone_identifier  = [aws_subnet.main.id]

  lifecycle {
    create_before_destroy = true
  }
}