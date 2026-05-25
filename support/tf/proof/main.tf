terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }

  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "aws" {
  region = var.region
}

# Unique nickname for this student's resources.
resource "random_pet" "student_id" {
  length = 2
}

# Upload student's SSH public key so the EC2 recognizes them.
resource "aws_key_pair" "student_key" {
  key_name   = "student-${random_pet.student_id.id}"
  public_key = var.student_public_key
}

# Cloud firewall: SSH + Minecraft + Dynmap, everything else closed.
resource "aws_security_group" "student_sg" {
  name        = "student-sg-${random_pet.student_id.id}"
  description = "SSH + Minecraft + Dynmap"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Minecraft"
    from_port   = 25565
    to_port     = 25565
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "BlueMap HTTP"
    from_port   = 8100
    to_port     = 8100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Latest official Ubuntu 22.04 LTS from Canonical.
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_instance" "student_instance" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.student_key.key_name
  vpc_security_group_ids      = [aws_security_group.student_sg.id]
  associate_public_ip_address = true

  tags = {
    Name    = "student-${random_pet.student_id.id}"
    Purpose = "DevOpsWorkshop"
    Owner   = "student-${random_pet.student_id.id}"
  }
}

# Provisioning: copy install.sh + minecraft.service to the box and run them.
# Using null_resource (not user_data) so failures surface in `terraform apply`,
# and so we can re-run with: terraform apply -replace=null_resource.minecraft_install
resource "null_resource" "minecraft_install" {
  depends_on = [aws_instance.student_instance]

  triggers = {
    instance_id     = aws_instance.student_instance.id
    install_script  = filemd5("${path.module}/install.sh")
    systemd_unit    = filemd5("${path.module}/minecraft.service")
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    host        = aws_instance.student_instance.public_ip
    private_key = file(pathexpand(var.ssh_private_key_path))
  }

  provisioner "file" {
    source      = "${path.module}/install.sh"
    destination = "/tmp/install.sh"
  }

  provisioner "file" {
    source      = "${path.module}/minecraft.service"
    destination = "/tmp/minecraft.service"
  }

  provisioner "remote-exec" {
    inline = ["bash /tmp/install.sh"]
  }
}
