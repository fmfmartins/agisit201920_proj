#resource "aws_vpc" "vpc" {
#  cidr_block = "172.31.0.0/16"
#}

#resource "aws_subnet" "subnet-public" {
#  vpc_id = "${aws_vpc.vpc.id}
#  cidr_block = "172.31.0.0/24"
#  map_public_ip_on_launch = “true”
#}

#resource "aws_internet_gateway" "gateway" {
#  vpc_id = "${aws_vpc.vpc.id}"
#}

#resource "aws_route_table" "route-table-public" {
#  vpc_id = "${aws_vpc.vpc.id}"
#
#  route {
#    cidr_block = "0.0.0.0/0"         //CRT uses this IGW to reach internet
#    gateway_id = "${aws_internet_gateway.gateway.id}" 
#  }
#}

#resource "aws_route_table_association" "route-table-subnet-public"{
#  subnet_id = "${aws_subnet.subnet-public.id}"
#  route_table_id = "${aws_route_table.route-table-public.id}"
#}

#resource "aws_security_group" "security-group" {
#  vpc_id = "${aws_vpc.vpc.id}"

#  egress {
#    from_port = 0
#    to_port = 0
#    protocol = -1
#    cidr_blocks = ["0.0.0.0/0"]
#  }

#  ingress {
#    from_port = 22
#    to_port = 22
#    protocol = "tcp"
#    // This means, all ip address are allowed to ssh ! 
#    // Do not do it in the production. 
#    // Put your office or home address in it!
#    cidr_blocks = ["0.0.0.0/0"]
#  }
  
#  //If you do not add this rule, you can not reach the NGINX  
#  ingress {
#    from_port = 80
#    to_port = 80
#    protocol = "tcp"
#    cidr_blocks = ["0.0.0.0/0"]
#  }

resource "aws_security_group" "security-group" {
  name = "security-group"
  tags = {
        Name = "security-group"
  }
  
  # Allow all inbound
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Enable ICMP
  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

