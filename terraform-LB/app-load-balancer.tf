resource "aws_lb" "load-balancer" {

    name = "lb-teraform-app"
    internal = false
    load_balancer_type = "application"
    subnets = [aws_subnet.pub-subnet1.id, aws_subnet.pub-subnet2.id]
    security_groups = [aws_security_group.lb-sg.id]
    depends_on         = [aws_internet_gateway.ig]
    

}



# Creating Listeners for the LB so it can route the traffic to the defined target group

resource "aws_lb_listener" "listener" {
   load_balancer_arn = aws_lb.load-balancer.arn
   port = 80
   protocol = "HTTP"


default_action {
   type = "forward"
   target_group_arn = aws_lb_target_group.target-group.arn

}

}


# Creating target group

resource "aws_lb_target_group" "target-group" {
    name = "alb-target-group"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.vpc.id

}
