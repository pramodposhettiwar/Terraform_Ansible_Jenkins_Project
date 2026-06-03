variable "vpc_cidr" {
    default = "10.0.0.0/16"
}
variable "sub_cidr" {
    default = "10.0.1.0/24"
}
variable "AWS_REGION" {
    default = "ap-southeast-1"
}
variable "amazon_AMI" {
    default = "ami-0543dbdaf4e114be7"
}
variable "amazon_instance_type" {
    default = "t2.micro"
}
variable "kp" {
    default = "singapore-linux-keypair-2026"
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
