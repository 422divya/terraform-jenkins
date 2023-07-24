resource "aws_autoscaling_group" "asg" {
     name = "auto-scaling"
     min_size = 1
     max_size = 5
     desired_capacity =  2
 #    availability_zones = ["ap-northeast-1a", "ap-northeast-1b"]
  
     vpc_zone_identifier = [ aws_subnet.private_subnet.id]
     # Connect to the target group
  target_group_arns = [aws_lb_target_group.target-group.arn]
   

launch_template {
   id = aws_launch_template.template.id
   version = "$Latest"
   

}


}
