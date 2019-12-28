#output "private_key"  {
#   value = file(var.ssh_key_private)
# }

#output "public_key"  {
#   value = file(var.ssh_key_public)
# }

output "keypair" {
  value = aws_key_pair.keypair.key_name
}

output "manager_public_ip" {
    value = ["${aws_instance.manager.public_ip}"]
}

output "worker_public_ips" {
      value = "${formatlist("%s = %s", aws_instance.worker[*].tags.Name, aws_instance.worker[*].public_ip)}"
}
