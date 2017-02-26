provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "ap-northeast-1"
}

# SSH public key
resource "aws_key_pair" "admin-key" {
  key_name = "admin-key"
  public_key = "${var.public-ssh-key}"
}

# instance
resource "aws_instance" "server" {
  ami = "ami-be4a24d9"  # Ubuntu Server 16.04 LTS (HVM) SSD
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.subnet.id}"
  key_name = "admin-key"
  associate_public_ip_address = true
  vpc_security_group_ids = [
    "${aws_security_group.terraform-asg.id}"
  ]

  tags {
    Name = "terraform"
  }
}

# VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags {
    Name = "terraform"
  }
}

resource "aws_security_group" "terraform-asg" {
  name = "terraform-asg"
  vpc_id = "${aws_vpc.main.id}"
  description = "Default security group"

  ingress = {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = "${var.permit_ip_list}"
  }

  ingress = {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress = {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress = {
    from_port = 60000
    to_port = 60010
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress = {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "terraform"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "10.0.10.0/24"

  tags {
    Name = "terraform"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "terraform"
  }
}

# route table
resource "aws_route_table" "public-rt" {
  vpc_id = "${aws_vpc.main.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags {
    Name = "terraform"
  }
}

resource "aws_route_table_association" "vpc-rta" {
  subnet_id = "${aws_subnet.subnet.id}"
  route_table_id = "${aws_route_table.public-rt.id}"
}

output "public ip of server" {
  value = "${aws_instance.server.public_ip}"
}
