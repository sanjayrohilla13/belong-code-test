variable "env" {
    description = "Application Environment"
    type = string
}

variable "app_name" {
    description = "Application Name"
    type = string
}

variable "region" {
    description = "AWS region for the Application"
    type = string
}

variable "az_list" {
    description = "AWS Availablity Zones for the application"
    type = string
}

variable "vpc_cidr_block" {
    description = "CIDR block for the VPC"
    type = string
}

variable "private_cidr_block" {
    description = "Private CIDR Block"
    type = string
}

variable "public_cidr_block" {
    description = "Public CIDR Block"
    type = string
}