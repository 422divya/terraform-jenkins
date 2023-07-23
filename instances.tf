resource "aws_instance"  "instance" {
   ami = var.ec2-instance["ami"]
   instance_type = var.ec2-instance["type"]
   
  # key_name = "source-pub-key"
   vpc_security_group_ids   = [aws_security_group.sg.id] 
   subnet_id = aws_subnet.pub-subnet.id
   tags = {
         Name = var.ec2-instance["name"]
}

}
