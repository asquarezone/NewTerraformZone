resource "aws_key_pair" "private" {
  key_name   = var.key_pair_info.key_pair_name
  public_key = file(var.key_pair_info.public_key_path)
}

resource "aws_instance" "web" {
  ami                    = var.web_server_info.ami_id
  instance_type          = var.web_server_info.instance_type
  vpc_security_group_ids = [aws_security_group.web.id]
  key_name               = aws_key_pair.private.key_name
  subnet_id              = aws_subnet.public_subnets[0].id
  associate_public_ip_address = true
  tags = {
    Name = "Web Server 1"
  }

}