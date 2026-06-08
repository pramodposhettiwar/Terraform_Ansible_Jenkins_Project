## 1. Create vpc =======================================
resource "aws_vpc" "dev-vpc" {
  cidr_block = "${var.vpc_cidr}"
  tags = {
    Name = "dev-vpc"
  }
}
##Create Subnet =========================================
resource "aws_subnet" "dev-subnet" {
  vpc_id            = aws_vpc.dev-vpc.id
  cidr_block        = "${var.sub_cidr}"
  map_public_ip_on_launch = "true"
  availability_zone = "ap-south-2a"
  tags = {
    Name = "dev-subnet"
  }
}
## create igw ============================================
resource "aws_internet_gateway" "dev-igw" {
  vpc_id = aws_vpc.dev-vpc.id
  tags = {
        Name = "dev-igw"
    }
}
##Create Custom Route Table ========================================
resource "aws_route_table" "dev-route-table" {
  vpc_id = aws_vpc.dev-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev-igw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.dev-igw.id
  }

  tags = {
    Name = "dev-route-table"
  }
}
##Associate subnet with Route Table ======================================
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.dev-subnet.id
  route_table_id = aws_route_table.dev-route-table.id
}
## Create Security Group =====================================================
resource "aws_security_group" "allow-web" {
  name        = "allow_web_traffic"
  description = "Allow Web inbound traffic"
  vpc_id      = aws_vpc.dev-vpc.id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
      }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow-web"
  }
}
## Create Ansible Node1 server ======================================================================
resource "aws_instance" "Node1" {
  ami               = "${var.amazon_AMI}"
  instance_type     = "${var.amazon_instance_type}"
  vpc_security_group_ids = [aws_security_group.allow-web.id]
  subnet_id              = aws_subnet.dev-subnet.id
  monitoring             = false
  key_name          = "${var.kp}"
  user_data = file("${path.module}/node.sh")
  tags = {
    Name = "Node1"
  }
}

## Create Ansible Node2 server ======================================================================
resource "aws_instance" "Node2" {
  ami               = "${var.amazon_AMI}"
  instance_type     = "${var.amazon_instance_type}"
  vpc_security_group_ids = [aws_security_group.allow-web.id]
  subnet_id              = aws_subnet.dev-subnet.id
  monitoring             = false
  key_name          = "${var.kp}"
  user_data = file("${path.module}/node.sh")
  tags = {
    Name = "Node2"
  }
}

## Create Ansible Node3 server ======================================================================
resource "aws_instance" "Node3" {
  ami               = "${var.amazon_AMI}"
  instance_type     = "${var.amazon_instance_type}"
  vpc_security_group_ids = [aws_security_group.allow-web.id]
  subnet_id              = aws_subnet.dev-subnet.id
  monitoring             = false
  key_name          = "${var.kp}"
  user_data = file("${path.module}/node.sh")
  tags = {
    Name = "Node3"
  }
}

## Create Ansible Control Node server ======================================================================
resource "aws_instance" "Ansible" {
  ami               = "${var.amazon_AMI}"
  instance_type     = "${var.amazon_instance_type}"
  vpc_security_group_ids = [aws_security_group.allow-web.id]
  subnet_id              = aws_subnet.dev-subnet.id
  monitoring             = false
  key_name          = "${var.kp}"
  user_data = file("${path.module}/ansible.sh")
    connection {
    type     = "ssh"
    user     = "root"
    password = var.root_pass
    host     = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [
      "echo '${aws_instance.Node1.private_ip} node1' >> /etc/hosts",
      "echo '${aws_instance.Node2.private_ip} node2' >> /etc/hosts",
      "echo '${aws_instance.Node3.private_ip} node3' >> /etc/hosts"
    ]
  }
  tags = {
    Name = "Ansible"
  }
}

