output "public_ip" {
  value = module.compute.public_ip
}

output "ssh_command" {
  value = module.compute.ssh_command
}
