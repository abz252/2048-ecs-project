resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  tags       = var.tags
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "public-1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidr1
  availability_zone = data.aws_availability_zones.available.names[0]
  tags              = var.tags
}

resource "aws_subnet" "private-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_cidr1
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = var.map_public_ip_on_launch
  tags                    = var.tags

}

resource "aws_subnet" "public-2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidr2
  availability_zone = data.aws_availability_zones.available.names[1]
  tags              = var.tags

}

resource "aws_subnet" "private-2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_cidr2
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = var.map_public_ip_on_launch
  tags                    = var.tags


}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags   = var.tags
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.public_route_cidr_block
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = var.tags
}

resource "aws_route_table_association" "public-1" {
  subnet_id      = aws_subnet.public-1.id
  route_table_id = aws_route_table.public.id

}

resource "aws_route_table_association" "public-2" {
  subnet_id      = aws_subnet.public-2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "nat" {
  domain = var.domain
  tags   = var.tags
}


resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public-1.id


  
  depends_on = [aws_internet_gateway.gw]

  tags = var.tags
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = var.private_route_cidr_block
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = var.tags
}

resource "aws_route_table_association" "private-1" {
  subnet_id      = aws_subnet.private-1.id
  route_table_id = aws_route_table.private.id


}

resource "aws_route_table_association" "private-2" {
  subnet_id      = aws_subnet.private-2.id
  route_table_id = aws_route_table.private.id

}
