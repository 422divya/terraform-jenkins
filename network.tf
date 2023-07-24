resource "aws_vpc" "vpc" {
    cidr_block = "10.0.0.0/24"
  tags = {
    Name = "test-vpc"
}
}



resource "aws_subnet" "pub-subnet" {
   vpc_id = aws_vpc.vpc.id
   cidr_block = "10.0.0.1/24"
   map_public_ip_on_launch = "true"
   availability_zone = "ap-northeast-1a"
   tags = {

    Name = "public-subnet"
}
}


resource "aws_internet_gateway" "ig" {
    vpc_id = aws_vpc.vpc.id
    tags = {

Name = "internet-gateway-test"

}

}


resource "aws_route_table" "test-route-table" {
   vpc_id = aws_vpc.vpc.id
  
route {
  cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.ig.id
}

tags = {
  Name = "public-route-table"
}

}



resource "aws_route_table_association" "route-subnet" {
   subnet_id = aws_subnet.pub-subnet.id
   route_table_id = aws_route_table.test-route-table.id
  

}

resource "aws_security_group" "sg" {
  name   = "HTTP and SSH"
  vpc_id = aws_vpc.some_custom_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}
