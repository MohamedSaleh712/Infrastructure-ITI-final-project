resource "aws_instance" "jumb_host_ec2" {
  ami                         = "ami-007855ac798b5175e"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnets["public_subnet_1"].id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.ec2_sg_public.id]
  key_name                    = "my-keypair"
  user_data                   = <<-EOF
    #!/bin/bash
    apt update -y
    apt-add-repository -y ppa:ansible/ansible
    apt-get -y install ansible
    apt update -y
    apt install python3-boto3 -y
    apt install awscli -y

  EOF

  provisioner "file" {
    source      = "../jenkins-deployment"
    destination = "/home/ubuntu/jenkins-deployment"
  }

  provisioner "file" {
    source      = "../ansible-playbooks"
    destination = "/home/ubuntu/ansible-playbooks"
  }

  provisioner "file" {
    source      = "../my-keypair.pem"
    destination = "/home/ubuntu/key"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("../my-keypair.pem")
    host        = self.public_ip
  }

  depends_on = [
    aws_eks_node_group.nodes_general,
    aws_eks_cluster.eks
  ]

  tags = {
    Name = "jumb_host"
  }
}


resource "aws_security_group" "ec2_sg_public" {
  name = "ec2_security_group_public"

  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.default_route]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.default_route]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.default_route]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.default_route]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.default_route]
  }
}

resource "aws_security_group" "eks_security_group" {
  name = "eks_security_group"

  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.default_route]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.default_route]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.default_route]
  }
}