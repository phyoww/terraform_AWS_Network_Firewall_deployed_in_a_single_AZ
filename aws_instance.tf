resource "aws_instance" "ec2_Instance_01" {
  instance_type               = "t2.micro"
  ami                         = "ami-03e312c9b09e29831"
  subnet_id                   = aws_subnet.cloudideastar_public_subnet.id
  security_groups             = [aws_security_group.securitygroup.id]
  associate_public_ip_address = true
  key_name                    = "testkeypair"
  disable_api_termination     = false
  ebs_optimized               = false
  root_block_device {
    volume_size = "10"
  }
  tags = {
    "Name" = "Cloudideastar_ec2_Instance_01"
  }
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("/Users/phyowaiwin/mydev-boxes/python-dev-box/Terraform-stuffs/mediacorp/AWS/project02_fw_with_vm/testkeypair.pem")
    host        = aws_instance.ec2_Instance_01.public_ip
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