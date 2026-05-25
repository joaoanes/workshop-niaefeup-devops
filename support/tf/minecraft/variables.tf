variable "student_public_key" {
  description = "Your SSH public key contents (run: cat ~/.ssh/id_ed25519.pub)"
  type        = string
}

variable "ssh_private_key_path" {
  description = "Path to the matching SSH private key on your laptop"
  type        = string
  default     = "~/.ssh/id_ed25519"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "instance_type" {
  description = "EC2 instance type — t3.small is the minimum for Minecraft + Dynmap"
  type        = string
  default     = "t3.small"
}
