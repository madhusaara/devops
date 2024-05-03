variable "cidr_block_value" {
	description	= "This mentions the cidr value of the vpc"
	default		= "10.0.0.16"
}

variable "eks_dedicated_public_cidrs" {
	description	= "This mentions the side value of public subnets"
	default		= ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "eks_dedicated_private_cidrs" {
	description	= "This mentions the cidr value of private subnets"
	default		= ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "availability_zones" {
	description	= "This mentions the availability zones to be used"
	default		= ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}

