#---------------------------------------------------------------------------------------
# Global Variables
#---------------------------------------------------------------------------------------
env      = "dev"
app_name = "CodeTestApp"
#---------------------------------------------------------------------------------------
# VPC Variables
#---------------------------------------------------------------------------------------
region             = "ap-southeast-2"
az_list            = ["ap-southeast-2a", "ap-southeast-2b"]   # Application will be deployed in 2 AZs 
vpc_cidr_block     = "10.0.0.0/25"                            # 128 IP address
private_cidr_blocks = ["10.0.0.0/28","10.0.0.16/28"]           # 16 IP Address per Subnet
public_cidr_blocks  = ["10.0.0.31/28","10.0.1.16/28"]        
#---------------------------------------------------------------------------------------
# EC2 Variables
#---------------------------------------------------------------------------------------
instance_type    = "t2.micro"
key_name         = "demo-app-key"
min_size         = 0
max_size         = 2
desired_capacity = 1
time_zone        = "Australia/Melbourne"