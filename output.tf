#=========== public ip address of ansible control Node =========================
output "ansible-control-node-public-ip" {
 	description = "Public IP address of ansible"
  	value = aws_instance.Ansible.public_ip
}
#=========== public & private ip address of Node1 =========================
output "node1-public-ip" {
 	description = "public ip address of node 1"
  	value = aws_instance.Node1.public_ip
}
output "node1-private-ip" {
 	description = "Private ip address of node 1"
  	value = aws_instance.Node1.private_ip
}
#=========== public & private ip address of Node2 =========================
output "node2-public-ip" {
 	description = "public ip address of node 2"
  	value = aws_instance.Node2.public_ip
}
output "node2-private-ip" {
 	description = "Private ip address of node 2"
  	value = aws_instance.Node2.private_ip
}
#=========== public & private ip address of Node3 =========================
output "node3-public-ip" {
 	description = "public ip address of node 3"
  	value = aws_instance.Node3.public_ip
}
output "node3-private-ip" {
 	description = "Private ip address of node 3"
  	value = aws_instance.Node3.private_ip
}
