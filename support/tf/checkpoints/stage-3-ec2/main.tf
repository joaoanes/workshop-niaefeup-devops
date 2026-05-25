terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "aws" {
  region = "eu-west-1"
}

variable "student_public_key" {
  description = "Your SSH public key (run: cat ~/.ssh/id_ed25519.pub)"
  type        = string
}

resource "random_pet" "student_id" {
  length = 2
}

resource "aws_key_pair" "student_key" {
  key_name   = "student-${random_pet.student_id.id}"
  public_key = var.student_public_key
}

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
    description = "Dynmap HTTP"
    from_port   = 8123
    to_port     = 8123
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

# Look up the latest official Ubuntu 22.04 AMI from Canonical.
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_instance" "student_instance" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.small" # 2GB RAM — Minecraft needs at least this
  key_name                    = aws_key_pair.student_key.key_name
  vpc_security_group_ids      = [aws_security_group.student_sg.id]
  associate_public_ip_address = true

  tags = {
    Name    = "student-${random_pet.student_id.id}"
    Purpose = "DevOpsWorkshop"
    Owner   = "student-${random_pet.student_id.id}"
  }
}

output "instance_public_ip" {
  value = aws_instance.student_instance.public_ip
}

output "ssh_command" {
  value = "ssh ubuntu@${aws_instance.student_instance.public_ip}"
}
