variable "env" {
  description = "Application Environment"
  type        = string
}

variable "app_name" {
  description = "Application Name"
  type        = string
}

variable "instance_type" {
  description = "Application Instance Type"
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

variable "private_subnet_ids" {
  description = "Private Subnet Ids"
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "Public Subnet Ids"
  type        = list(string)
}

variable "app_vpc_id" {
  description = "Application VPC Id"
  type        = string
}

variable "private_cidr_blocks" {
  description = "Private CIDR Block"
  type        = list(string)
}

variable "key_name" {
  description = "Key Pair for the Application and Jump Server"
  type        = string
}

variable "time_zone" {
  description = "Time Zone of the application"
  type        = string
}

variable "az_list" {
  description = "Availablity Zone List"
  type        = list(string)
}

variable "app_instance_profile" {
  description = "IAM instance Profile"
  type        = string
}

variable "cooldown_period" {
  description = "cool down time for Application ASG"
  type        = string
}

variable "scale_out_adjustment" {
  description = "No of Instances to be added while Scale out event"
  type        = number
}

variable "scale_in_adjustment" {
  description = "No of Instances to be removed while Scale in event"
  type        = number
}

variable "cw_high_threshold" {
  description = "Cloud Watch High Threshold for Scale Out"
  type        = string
}

variable "cw_low_threshold" {
  description = "Cloud Watch Low Threshold for Scale In"
  type        = string
}
