resource "aws_key_pair" "keypair" {
  key_name = "osmgmt_swarm"
  public_key = file(var.ssh_key_public)
}

resource "aws_instance" "manager" {
  ami = "ami-00068cd7555f543d5"
  instance_type = "t2.micro"
  key_name = aws_key_pair.keypair.key_name
  vpc_security_group_ids = [aws_security_group.security-group.id]
  availability_zone = "us-east-1a"
  private_ip = "172.31.1.1"

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
  availability_zone = "us-east-1a"
  private_ip = "172.31.10.${count.index+1}"

  tags = {
    Name = "worker${count.index+1}"
  }

}
