# Multi-Container Infrastructure with Terraform

This project demonstrates the creation of a highly available, multi-container infrastructure using Terraform.
It includes the provisioning of an Amazon Web Services (AWS) Virtual Private Cloud (VPC) along with essential resources and the orchestration of three containers using Docker Compose. 
The result is a web application that reads data from two databases (MySQL and MongoDB) using a PHP script.

## Terraform Infrastructure

- **Provider:** AWS

### Resources

- **VPC (Virtual Private Cloud)**
  - **CIDR Block:** 10.0.0.0/16

- **Internet Gateway**
  - Associates with the VPC for public internet access.

- **Subnet**
  - **CIDR Block:** 10.0.1.0/24
  - Associates with the VPC.

- **Security Group**

  - Allows incoming and outgoing traffic for various ports including 22 (SSH), 3306 (MySQL), 27017 (MongoDB), 8080 (Web App), 80 (HTTP). Egress (Outgoing) traffic is allowed to all destinations.

- **Route Table**
  - Creates a default route table associated with the VPC and directs traffic to the Internet Gateway.

- **Main Route Table Association**
  - Associates the main route table with the VPC.

- **Launch Configuration**
  - **Amazon Machine Image (AMI):** (Amazon Linux 2)
  - Installs Docker, Apache (httpd), and Docker Compose.
  - Creates directories for MongoDB, MySQL, and PHP App.

- **Autoscaling Group**
  - **Desired Capacity:** 2
  - **Maximum Capacity:** 5
  - **Minimum Capacity:** 1
 
## Docker Containers

- **Web Frontend**
  - **Image:** PHP 7.0.33 with Xdebug and Apache
  - Configured to run a PHP web application.
  - Exposes port 80 (HTTP).

- **MySQL**
  - **Image:** MySQL 5.7
  - Runs a MySQL database.
  - Exposes port 3306.

- **MongoDB**
  - **Image:** MongoDB 4.2
  - Runs a MongoDB database.
  - Exposes port 27017.
