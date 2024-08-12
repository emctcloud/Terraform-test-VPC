resource "aws_subnet" "public_subnet_1a" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, 1)
  availability_zone       = "${data.aws_region.current.name}a"
  map_public_ip_on_launch = true

  tags = merge(
    local.tags, {
      Name                     = "${var.project_name}-pub-SUBNET-1A"
      "kubernetes.io/role/elb" = 1
    }
  )
}
resource "aws_subnet" "public_subnet_1b" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, 2)
  availability_zone       = "${data.aws_region.current.name}b"
  map_public_ip_on_launch = true

  tags = merge(
    local.tags, {
      Name                     = "${var.project_name}-pub-SUBNET-1B"
      "kubernetes.io/role/elb" = 1
    }
  )
}

resource "aws_route_table_association" "rtb_assoc_1a" {
  subnet_id      = aws_subnet.public_subnet_1a.id
  route_table_id = aws_route_table.public_route_table.id
}
resource "aws_route_table_association" "rtb_assoc_1b" {
  subnet_id      = aws_subnet.public_subnet_1b.id
  route_table_id = aws_route_table.public_route_table.id
}