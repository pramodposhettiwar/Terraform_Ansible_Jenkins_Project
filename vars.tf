variable "vpc_cidr" {
    default = "10.0.0.0/16"
}
variable "sub_cidr" {
    default = "10.0.1.0/24"
}
variable "AWS_REGION" {
    default = "ap-south-2"
}
variable "amazon_AMI" {
    default = "ami-04e44fc07a0954cc9"
}
variable "amazon_instance_type" {
    default = "t3.micro"
}
variable "kp" {
    default = "linux-hyderabad-keypair-2026"
}
variable "akey" {
    default = ""
}
variable "skey" {
    default = ""
}
variable "root_pass" {
    default = "111"
}
