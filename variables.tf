variable "env" {
  description = "Application Environment"
  type        = string
}

variable "app_name" {
  description = "Application Name"
  type        = string
}

variable "region" {
  description = "AWS region for the Application"
  type        = string
}

variable "az_list" {
  description = "AWS Availablity Zones for the application"
  type        = list(string)
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "private_cidr_block" {
  description = "Private CIDR Block"
  type        = string
}

variable "public_cidr_block" {
  description = "Public CIDR Block"
  type        = string
}

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# ec2 Module Variables
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
variable "instance_type" {
  description = "Application Instance Type"
  type        = string
}

variable "key_name" {
  description = "Key Pair Name for WebServer and Jump Server"
  type        = string
}

variable "min_size" {
  description = "ASG Min Size"
  type        = string
}

variable "max_size" {
  description = "ASG Max Size"
  type        = string
}

variable "desired_capacity" {
  description = "ASG Desired Capacity"
  type        = string
}

variable "time_zone" {
  description = "Time Zone of the application"
  type        = string
}