output "ssh_swarm_keypair" {
  value = aws_key_pair.keypair.key_name
}

output "swarm_manager_public_ip" {
    value = [aws_instance.manager.public_ip]
}

output "swarm_worker_public_ip" {
      value = "${formatlist("%s = %s", aws_instance.worker[*].tags.Name, aws_instance.worker[*].public_ip)}"
}
