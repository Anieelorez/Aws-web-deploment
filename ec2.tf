data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}


# launch ec2 instance and install your website
resource "aws_instance" "web" {
  ami                    = data.aws_ami.amazon_linux_2.id
  subnet_id              = aws_subnet.public_subnet_az1.id
  instance_type          = "t3.micro"
  key_name               = "Annie"
  vpc_security_group_ids = [aws_security_group.webserver_security_group.id]
  user_data              = file("command.sh")

  tags = {
    Name = "web-instance"
  }
}