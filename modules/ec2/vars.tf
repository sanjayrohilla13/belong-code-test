variable "env" {
    description = "Application Environment"
    type = string
}

variable "app_name" {
    description = "Application Name"
    type = string
}

variable "instance_type" {
    description = "Application Instance Type"
    type = string
}

variable "min_size" {
  description = "ASG Min Size"
  type = string
}

variable "max_size" {
  description = "ASG Max Size"
  type = string
}

variable "desired_capacity" {
  description = "ASG Desired Capacity"
  type = string
}

variable "private_subnet_id" {
    description = "Private Subnet Id"
    type = string
}

variable "public_subnet_id" {
    description = "Public Subnet Id"
    type = string
}

variable "app_vpc_id" {
    description = "Application VPC Id"
    type = string
}

variable "private_cidr_block" {
    description = "Private CIDR Block"
  type = string
}

variable "key_name" {
    description = "Key Pair for the Application and Jump Server"
    type = string
}

variable "time_zone" {
    description = "Time Zone of the application"
    type = string
}