resource "aws_instance" "web_instance" {
  ami           = "ami-03e312c9b09e29831"
  instance_type = "t2.micro"
  key_name      = "testing"
  
  subnet_id                   = aws_subnet.cloudideastar_public_subnet.id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true

  user_data = <<-EOF
  #!/bin/bash -ex

  amazon-linux-extras install nginx1 -y
  echo "<h1>$(curl https://api.cloudideastar.rest/?format=text)</h1>" >  /usr/share/nginx/html/index.html 
  systemctl enable nginx
  systemctl start nginx
  EOF

  tags = {
    "Name" : "Cloudideastar"
  }
}
