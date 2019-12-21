resource "aws_key_pair" "keypair" {
  key_name = "osmgmt_swarm"
  public_key = file(var.ssh_key_public)
}

resource "aws_instance" "manager" {
  ami = "ami-00068cd7555f543d5"
  instance_type = "t2.micro"
  key_name = aws_key_pair.keypair.key_name
  vpc_security_group_ids = [aws_security_group.security-group.id]
  private_ip = "172.31.36.1"

  tags = {
    Name = "manager"
  }
}

resource "aws_instance" "worker" {
  count = 2
  ami = "ami-00068cd7555f543d5"
  instance_type = "t2.micro"
  key_name = aws_key_pair.keypair.key_name
  vpc_security_group_ids = [aws_security_group.security-group.id]
  private_ip = "172.31.35.${count.index+1}"

  tags = {
    Name = "worker${count.index+1}"
  }

}
