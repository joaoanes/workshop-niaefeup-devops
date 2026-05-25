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
  region = "eu-west-1"
}

variable "student_public_key" {
  description = "Your SSH public key (run: cat ~/.ssh/id_ed25519.pub)"
  type        = string
}

variable "ssh_private_key_path" {
  description = "Path to the matching SSH private key on your laptop"
  type        = string
  default     = "~/.ssh/id_ed25519"
}

# URLs to the prebuilt Minecraft server JAR and Dynmap plugin.
# IMPORTANT: replace these with real, pinned URLs you've tested.
# Spigot in particular cannot be redistributed; either build it with BuildTools
# beforehand and mirror it in your own S3 bucket, or use Paper/Purpur.
variable "minecraft_server_jar_url" {
  description = "Direct download URL for the Minecraft server JAR"
  type        = string
  default     = "https://api.papermc.io/v2/projects/paper/versions/1.21/builds/130/downloads/paper-1.21-130.jar"
}

variable "dynmap_jar_url" {
  description = "Direct download URL for the Dynmap plugin JAR"
  type        = string
  default     = "https://mediafilez.forgecdn.net/files/5524/641/Dynmap-3.7-beta-9-spigot.jar"
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

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_instance" "student_instance" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.small"
  key_name                    = aws_key_pair.student_key.key_name
  vpc_security_group_ids      = [aws_security_group.student_sg.id]
  associate_public_ip_address = true

  tags = {
    Name    = "student-${random_pet.student_id.id}"
    Purpose = "DevOpsWorkshop"
    Owner   = "student-${random_pet.student_id.id}"
  }
}

# Install Minecraft + Dynmap on the box after it exists.
# We use null_resource (not user_data) so failures surface in the terraform
# output, and so we can re-run the install with:
#   terraform apply -replace=null_resource.minecraft_install
resource "null_resource" "minecraft_install" {
  depends_on = [aws_instance.student_instance]

  triggers = {
    # Re-run the install when the instance is replaced.
    instance_id = aws_instance.student_instance.id
    # Re-run when the URLs change.
    server_url  = var.minecraft_server_jar_url
    dynmap_url  = var.dynmap_jar_url
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    host        = aws_instance.student_instance.public_ip
    private_key = file(pathexpand(var.ssh_private_key_path))
  }

  provisioner "remote-exec" {
    inline = [
      # Wait for cloud-init to finish so apt doesn't fight with it.
      "cloud-init status --wait || true",

      "sudo apt-get update -y",
      "sudo apt-get install -y openjdk-21-jre-headless wget",

      "sudo mkdir -p /opt/minecraft/plugins",
      "sudo chown -R ubuntu:ubuntu /opt/minecraft",

      "wget -qO /opt/minecraft/server.jar '${var.minecraft_server_jar_url}'",
      "wget -qO /opt/minecraft/plugins/Dynmap.jar '${var.dynmap_jar_url}'",
      "echo 'eula=true' > /opt/minecraft/eula.txt",

      # Create a systemd unit so the server survives logout/reboot
      # and gets restarted if it crashes.
      "sudo tee /etc/systemd/system/minecraft.service > /dev/null <<'EOF'\n[Unit]\nDescription=Minecraft Server\nAfter=network.target\n\n[Service]\nUser=ubuntu\nWorkingDirectory=/opt/minecraft\nExecStart=/usr/bin/java -Xmx1500M -Xms1500M -jar /opt/minecraft/server.jar nogui\nRestart=on-failure\nRestartSec=10\n\n[Install]\nWantedBy=multi-user.target\nEOF",

      "sudo systemctl daemon-reload",
      "sudo systemctl enable --now minecraft.service",
    ]
  }
}

output "instance_public_ip" {
  value = aws_instance.student_instance.public_ip
}

output "ssh_command" {
  value = "ssh ubuntu@${aws_instance.student_instance.public_ip}"
}

output "minecraft_address" {
  value = "${aws_instance.student_instance.public_ip}:25565"
}

output "dynmap_url" {
  value = "http://${aws_instance.student_instance.public_ip}:8123"
}
