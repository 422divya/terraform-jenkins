resource "aws_vpc" "vpc" {
    cidr_block = "10.0.0.0/23"
  tags = {
    Name = "test-vpc"
}
}



resource "aws_subnet" "pub-subnet1" {
   vpc_id = aws_vpc.vpc.id
   cidr_block = "10.0.0.0/27"  #256 IPs
   map_public_ip_on_launch = "true"
   availability_zone = "ap-northeast-1a"
   tags = {

    Name = "public-subnet1"
}
}

resource "aws_subnet" "pub-subnet2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.0.32/27"
  map_public_ip_on_launch = true           # public subnet
  availability_zone       = "ap-northeast-1c"
}

# Creating 1st private subnet 
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.1.0/27" #32 IPs
  map_public_ip_on_launch = false         # private subnet
  availability_zone       = "ap-northeast-1c"
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
   subnet_id = aws_subnet.pub-subnet1.id
   route_table_id = aws_route_table.test-route-table.id
  

}

resource "aws_route_table_association" "route-subnet2" {
   subnet_id = aws_subnet.pub-subnet2.id
   route_table_id = aws_route_table.test-route-table.id


}





resource "aws_eip" "elastic_ip" {
  depends_on = [aws_internet_gateway.ig]
  vpc        = true
#    domain = aws_vpc.vpc.id
  tags = {
    Name = "EIP-NAT"
  }
}

# Creating nat-gateway for the instances in private subnet to communicate woth the internet

resource "aws_nat_gateway" "nat-gate" {
   allocation_id = aws_eip.elastic_ip.id
   subnet_id = aws_subnet.pub-subnet1.id
  tags = {

    Name = "nat-gateway-terraform"
}

depends_on = [aws_internet_gateway.ig]
 

}



resource "aws_route_table" "route-table-private" {
     vpc_id = aws_vpc.vpc.id


route {
   cidr_block = "0.0.0.0/0"
   nat_gateway_id = aws_nat_gateway.nat-gate.id

}
}


# associate the above route table with private subnet

resource "aws_route_table_association" "route-private" {
  subnet_id = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.route-table-private.id

}
