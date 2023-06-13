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
  # Installing required softwares into the system!
  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = file("/testkeypair.pem") #paste your xxx.pem file patch from your pc
    host = aws_instance.web_instance.public_ip
  }

  # Code for installing the softwares!
  provisioner "remote-exec" {
    inline = [
        "sudo yum update -y",
        "sudo yum install php php-mysqlnd httpd -y",
        "wget https://wordpress.org/wordpress-4.8.14.tar.gz",
        "tar -xzf wordpress-4.8.14.tar.gz",
        "sudo cp -r wordpress /var/www/html/",
        "sudo chown -R apache.apache /var/www/html/",
        "sudo systemctl start httpd",
        "sudo systemctl enable httpd",
        "sudo systemctl restart httpd"
    ]
  }    
}
