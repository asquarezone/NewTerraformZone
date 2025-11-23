module "primary_vpc" {
  source = "./modules/vpc"
  providers = {
    aws = aws.primary
  }
  vpc_info = {
    cidr                 = "10.100.0.0/16"
    enable_dns_hostnames = true
    tags = {
      Name = "primary"
    }
  }
  public_subnets = [{
    az   = "us-west-2a",
    cidr = "10.100.0.0/24",
    tags = {
      Name = "web1"
    }
    }, {
    az   = "us-west-2b",
    cidr = "10.100.1.0/24",
    tags = {
      Name = "web2"
    }
  }]
  private_subnets = [{
    az   = "us-west-2a",
    cidr = "10.100.2.0/24",
    tags = {
      Name = "app1"
    }
    }, {
    az   = "us-west-2b",
    cidr = "10.100.3.0/24",
    tags = {
      Name = "app2"
    }
    }, {
    az   = "us-west-2a",
    cidr = "10.100.4.0/24",
    tags = {
      Name = "db1"
    }
    }, {
    az   = "us-west-2b",
    cidr = "10.100.5.0/24",
    tags = {
      Name = "db2"
    }
  }]

}

module "secondary_vpc" {
  source = "./modules/vpc"
  providers = {
    aws = aws.secondary
  }
  vpc_info = {
    cidr                 = "10.101.0.0/16"
    enable_dns_hostnames = true
    tags = {
      Name = "secondary"
    }
  }
  public_subnets = [{
    az   = "us-east-1a",
    cidr = "10.101.0.0/24",
    tags = {
      Name = "web1"
    }
    }, {
    az   = "us-east-1b",
    cidr = "10.101.1.0/24",
    tags = {
      Name = "web2"
    }
  }]
  private_subnets = [{
    az   = "us-east-1a",
    cidr = "10.101.2.0/24",
    tags = {
      Name = "app1"
    }
    }, {
    az   = "us-east-1b",
    cidr = "10.101.3.0/24",
    tags = {
      Name = "app2"
    }
    }, {
    az   = "us-east-1a",
    cidr = "10.101.4.0/24",
    tags = {
      Name = "db1"
    }
    }, {
    az   = "us-east-1b",
    cidr = "10.101.5.0/24",
    tags = {
      Name = "db2"
    }
  }]

}


module "primary_web_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.0.0" # use an appropriate version

  name        = "my-security-group"
  description = "Allow SSH and HTTP inbound"
  vpc_id      = module.primary_vpc.vpc_id # pass your VPC ID here

  # Ingress CIDR blocks for SSH and HTTP
  ingress_cidr_blocks = ["0.0.0.0/0"]

  # Use predefined named rules
  ingress_rules = [
    "ssh-tcp",    # port 22
    "http-80-tcp" # port 80
  ]

  # Allow all outbound
  egress_rules = ["all-all"]

  tags = {
    Terraform = "true"
    Name      = "Web"
  }
  providers = {
    aws = aws.primary
  }
}

module "secondary_web_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.0.0" # use an appropriate version

  name        = "my-security-group"
  description = "Allow SSH and HTTP inbound"
  vpc_id      = module.secondary_vpc.vpc_id # pass your VPC ID here

  # Ingress CIDR blocks for SSH and HTTP
  ingress_cidr_blocks = ["0.0.0.0/0"]

  # Use predefined named rules
  ingress_rules = [
    "ssh-tcp",    # port 22
    "http-80-tcp" # port 80
  ]

  # Allow all outbound
  egress_rules = ["all-all"]

  tags = {
    Terraform = "true"
    Name      = "Web"
  }
  providers = {
    aws = aws.secondary
  }
}



# import a key pair

resource "aws_key_pair" "primary" {
  region     = "us-west-2"
  public_key = file(var.key_path)
  provider   = aws.primary
  key_name   = "primary"
}

resource "aws_key_pair" "secondary" {
  region     = "us-east-1"
  public_key = file(var.key_path)
  provider   = aws.primary
  key_name   = "secondary"
}

data "aws_ami" "ubuntu_primary" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners   = ["099720109477"] # Canonical
  provider = aws.primary
}


module "primary_web" {
  source            = "./modules/ec2"
  ami_id            = data.aws_ami.ubuntu_primary.id
  instance_type     = "t3.micro"
  security_group_id = module.primary_web_sg.security_group_id
  key_name          = aws_key_pair.primary.key_name
  subnet_id         = module.primary_vpc.public_subnet_ids[0]
  user_data         = file("./cloud_init.sh")
  build_id          = var.build_id
  providers = {
    aws = aws.primary
  }

}

data "aws_ami" "ubuntu_secondary" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners   = ["099720109477"] # Canonical
  provider = aws.secondary
}


module "secondary_web" {
  source            = "./modules/ec2"
  ami_id            = data.aws_ami.ubuntu_secondary.id
  instance_type     = "t3.micro"
  security_group_id = module.secondary_web_sg.security_group_id
  key_name          = aws_key_pair.secondary.key_name
  subnet_id         = module.secondary_vpc.public_subnet_ids[0]
  user_data         = file("./cloud_init.sh")
  build_id          = var.build_id
  providers = {
    aws = aws.secondary
  }

}
