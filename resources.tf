resource "aws_vpc" "eks_dedicated" {
	cidr_block	= var.cidr_block_value

	tags = {
		Name	= "eks_dedicated"
	}
}

resource "aws_subnet" "eks_dedicated_public" {
	count 	= length(var.eks_dedicated_public_cidrs)
	vpc_id	= aws_vpc.eks_dedicated.id
	cidr_block = element(var.eks_dedicated_public_cidrs, count.index)
	availability_zone = element(var.availability_zones, count.index)
	tags	= {
		Name = "public subnet ${count.index +1}"
	}
}

resource "aws_subnet" "eks_dedicated_private" {
	count	= length(var.eks_dedicated_private_cidrs)
	vpc_id	= aws_vpc.eks_dedicated.id
	cidr_block = element(var.eks_dedicated_private_cidrs, count.index)
	availability_zone = element(var.availability_zones, count.index)
	tags	= {
		Name = "private subnet ${count.index +1}"
	}	
}

resource "aws_internet_gateway" "eks_dedicated_IG" {
	vpc_id = aws_vpc.eks_dedicated.id

	tags	= {
		Name = "eks_dedicated IG"
	}
}

resource "aws_route_table" "RT_for_publicsubnets" {
	vpc_id = aws_vpc.eks_dedicated.id
	
	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = aws_internet_gateway.eks_dedicated_IG.id
	}

	tags 	= {
		Name = "RT for publicsubnets"
	}
}

resource "aws_route_table_association" "public_subnet_asso" {
	count	= length(var.eks_dedicated_public_cidrs)
	subnet_id = element(aws_subnet.eks_dedicated_public[*].id, count.index)
	route_table_id = aws_route_table.RT_for_publicsubnets.id
}


