resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.eks_vpc.id
  tags = merge(
    local.tags, {
      Name = "${var.project_name}-IGW"
    }
  )
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(
    local.tags, {
      Name = "${var.project_name}-pub-route-table"
    }
  )
}