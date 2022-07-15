# belong-code-test
Requirement:
------------------------------------------------------------------------------------------------------------
Challenge Scenario:
------------------------------------------------------------------------------------------------------------
As the platform/systems team, we have been asked to deliver a standard secure infrastructure on our AWS Cloud Account with following requirements:
Infra Requirements:
• A dedicated VPC with public and private subnets.
• An EC2 in the private subnet running httpd as a service. The timezone of the machine should be set to AEST.
• Download the file belong-test.html from S3 Bucket (belong-coding-challenge) in Sydney region and service it through httpd running as a service on the instance.
• Developers require terminal access to the EC2 for further configuration/administration.

Notes:
• IaC tool of choice is Cloudformation.
• Solution should be reliable, secure and would soon go into production.

We'll evaluate the submission on your problem solving approach, simplicity, code quality,
and use of Cloud best practices within the solution.
Feel free to be creative and take liberties where you feel it will improve the deliverable!
------------------------------------------------------------------------------------------------------------
Proposed Solution:
------------------------------------------------------------------------------------------------------------

For above code challenge, I hereby purpose the below solution:
1. The application will be deployed in Sydney (ap-southeast-2) region; the region name is configurable from the variable parameter (terraform.tfvars) file.

2. The application will be deployed in two AZs of the above defined region for high availablity. AZ's are also configurable from the parameter file terraform.tfvars. The AZs should belong to the same region. 

3. The EC2 instances hosting http server will be running in the private AZs for increased security and will be accessable from within the VPC network only. 
4. The EC2 instances will be provisioned by Auto Scaling Group with scale out and scale in policies with CloudWatch Service. 
5. All of the parameters for Auto Scaling configurations like max size, min size and desired capacity, cool down time, High Threshold, low threshold are configurable and can be defined in the variable parameter file depending upon the requirements of the application.

4. The terminal access to the EC2 (hosting httpd service) will be through jump server provisioned using Jump-server ASG. The ASG will be capable of provisioning the Jump server in both the AZs to keep the jump server highly available in case of one AZ is down.

5. The S3 bucket will be accessed using VPC Gateway endpoint to cut the cost for accessing the bucket from public internet. 

