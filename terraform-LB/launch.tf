resource "aws_launch_template" "template" {
    name = "launch-template"
    image_id = var.ec2-instance["ami"] 
    instance_type = var.ec2-instance["type"]
    user_data = filebase64("script.sh") 

}
