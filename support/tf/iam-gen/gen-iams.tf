provider "aws" {
  region = "eu-west-1"
}

variable "student_count" {
  default = 20
}

resource "aws_iam_group" "students" {
  name = "workshop-4h-students"
}

resource "aws_iam_group_policy" "student_policy" {
  name  = "ec2-only-access"
  group = aws_iam_group.students.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ec2:*",
          "cloudwatch:Describe*",
          "cloudwatch:Get*",
          "cloudwatch:List*"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_user" "student" {
  count = var.student_count
  name  = "student-${count.index + 1}"
}

resource "aws_iam_user_group_membership" "membership" {
  count  = var.student_count
  user   = aws_iam_user.student[count.index].name
  groups = [aws_iam_group.students.name]
}

resource "aws_iam_access_key" "student_key" {
  count = var.student_count
  user  = aws_iam_user.student[count.index].name
}

output "student_credentials" {
  value = [
    for i in range(var.student_count) : {
      username   = aws_iam_user.student[i].name,
      access_key = aws_iam_access_key.student_key[i].id,
      secret_key = aws_iam_access_key.student_key[i].secret
    }
  ]
  sensitive = true
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "local" {
    path = "terraform.tfstate"
  }
}
