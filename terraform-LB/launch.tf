resource "aws_launch_template" "template" { 
    name_prefix = "Dev-instance-"
    image_id = var.ec2-instance["ami"] 
    instance_type = var.ec2-instance["type"]
    key_name = module.key_pair.key_pair_name

   tags = {
      Name = "dev-launch-template"
    

}
user_data = filebase64("pubkey.sh")
}  
