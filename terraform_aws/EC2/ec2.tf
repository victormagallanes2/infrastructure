resource "aws_instance" "terraform-ec2" {
  ami           = "ami-0ad8410c434dca64c"
  instance_type = "t2.micro"
  vpc_security_group_ids  = [var.ssh-access]
  subnet_id = var.public_subnet_id_a


  tags = {
    Name = "ubuntu22.04"
  }
}


