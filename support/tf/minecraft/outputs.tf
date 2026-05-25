output "student_id" {
  description = "Your generated nickname for this workshop"
  value       = random_pet.student_id.id
}

output "instance_public_ip" {
  value = aws_instance.student_instance.public_ip
}

output "ssh_command" {
  value = "ssh ubuntu@${aws_instance.student_instance.public_ip}"
}

output "minecraft_address" {
  description = "Paste this into Minecraft → Multiplayer → Add Server"
  value       = "${aws_instance.student_instance.public_ip}:25565"
}

output "bluemap_url" {
  description = "Open in a browser for the live map"
  value       = "http://${aws_instance.student_instance.public_ip}:8100"
}
