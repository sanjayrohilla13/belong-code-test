#---------------------------------------------------------------------------------------
# Global Variables
#---------------------------------------------------------------------------------------
env        = "dev"
app_name   = "CodeTestApp"
#---------------------------------------------------------------------------------------
# VPC Variables
#---------------------------------------------------------------------------------------
region              = "ap-southeast-2"
az_list             = ["ap-southeast-2a", "ap-southeast-2b"] # Application will be deployed in 2 AZs 
vpc_cidr_block      = "10.0.0.0/24"                          # 256 IP address 10.0.0.0 to 10.0.0.255
private_cidr_blocks = ["10.0.0.0/28", "10.0.0.16/28"]        # 16 IP Address per Subnet
# Public S/N - 10.0.0.0  - 10.0.0.15 
# Public S/N - 10.0.0.16 - 10.0.0.31
public_cidr_blocks = ["10.0.0.32/28", "10.0.0.48/28"] # Privaate S/N 10.0.0.32 - 10.0.0.47
# Private S/N  10.0.0.48 - 10.0.0.63 
#---------------------------------------------------------------------------------------
# EC2 Variables
#---------------------------------------------------------------------------------------
instance_type    = "t2.micro"
key_name         = "demo-app-key"
min_size         = 0
max_size         = 2
desired_capacity = 2
time_zone        = "Australia/Melbourne"