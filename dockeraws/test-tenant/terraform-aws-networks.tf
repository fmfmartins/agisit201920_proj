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

resource "aws_security_group" "security-group" {
  name = "agisit-security-group"
  tags = {
        Name = "security-group"
  }

  # Allow Swarm ESP
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "50"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow Swarm
  ingress {
    from_port   = 2377
    to_port     = 2377
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow Grafana
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow Docker Swarm Gossip
  ingress {
    from_port   = 7946
    to_port     = 7946
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 7946
    to_port     = 7946
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow cAdvisor
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Allow node-exporter
  ingress {
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow Docker Prometheus Exporter
  ingress {
    from_port   = 9323
    to_port     = 9323
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #ingress {
  #  from_port   = 0
  #  to_port     = 65535
  #  protocol    = "tcp"
  #  cidr_blocks = ["0.0.0.0/0"]
  #}

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
