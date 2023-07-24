
variable "ec2-instance" {
type = object ({

name = string
ami = string
type = string

})

default = {
 name = "terraform-instance"
 ami = "ami-01b32aa8589df6208"
 type = "t2.micro" 


}

}
