resource "aws_key_pair" "keypair" {
  key_name = "keypair"
  public_key = file(var.ssh_key_public)
}

resource "aws_instance" "manager" {
  ami = "ami-00068cd7555f543d5"
  instance_type = "t2.micro"
  key_name = aws_key_pair.keypair.key_name
  vpc_security_group_ids = [aws_security_group.security-group.id]
  
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

  tags = {
    Name = "worker ${count.index+1}"
  }
}
