resource "aws_instance" "base" {
  ami                         = var.ami_id
  associate_public_ip_address = true
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  key_name                    = var.key_name

  
}

resource "null_resource" "base" {
  triggers = {
    build_id = var.build_id
  }
  provisioner "remote-exec" {
    connection {
      host = aws_instance.base.public_ip
      user = "ubuntu"
      private_key = file("~/.ssh/id_ed25519")
    }
    inline = [
      "sudo apt update",
      "sudo apt install apache2 -y",
      "sudo apt install tree php -y"
    ]
    
  }
  depends_on = [ aws_instance.base ]

  
}
