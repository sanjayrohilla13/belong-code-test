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

3. The EC2 instances hosting http server will be running in the private AZs for increased security and will be accessable from within the VPC network only for configuration and administration. 

4. The EC2 instances will be provisioned by Auto Scaling Group with scale out and scale in policies with CloudWatch Service to provision the instances based on the EC2 instance load.

5. All of the parameters for Auto Scaling configurations like max size, min size and desired capacity, cool down time, High Threshold, low threshold are configurable and can be defined in the variable parameter file depending upon the requirements of the application.

4. The terminal access to the EC2 (hosting httpd service) will be through jump server provisioned using Jump-server ASG. The ASG will be capable of provisioning the Jump server in both the AZs to keep the jump server highly available in case of one AZ is down.

5. The S3 bucket will be accessed using VPC Gateway endpoint for cost and performance reasons than accessing the bucket from public internet. 

6. The current setup is configured to run in two AZs. This can be easily configured to run in mulitple AZs by changing the below parameters from dev-codetest/terraform.tfvars file
    1. Add the new AZ to the az_list
    2. Change the CIDR Range for VPC (In case application needs more than 206 Ip addresses)
    2. Add the new CIDR Range in Public Cidr Range and Private Cidr Range
------------------------------------------------------------------------------------------------------------
Application Deployment Steps
------------------------------------------------------------------------------------------------------------
Application can be be deployed in dev enviornment using an automation tool in steps:
1. Create a Job for deploying backend architecture (backend bucket and a dynamodb statelock table) with below commands (This job should be executed only while provisioning the new enviornment):
      cd domain/dev-backend-setup/
      terraform init
      terraform plan
      terraform apply -auto-approve 

    same job can be configured to destroy the infrastructure based on parameter if required. However it is not recommended to destroy the infrastructre if the bucket is being used by some other infra configuration.
      cd domain/dev-backend-setup/
      terraform init
      terraform plan - destroy
      terraform destroy -auto-approve 
    
2. Create a job for deploying the application in AWS Environment using below commands
      cd domain/dev-codetest/
      terraform init
      terraform plan
      terraform apply -auto-approve

    same job can be configured to destroy the backend infrastructure based on parameter.  
      cd domain/dev-codetest/
      terraform init
      terraform plan -destroy
      terraform destroy -auto-approve
------------------------------------------------------------------------------------------------------------
Deploying the application in a New Environment
------------------------------------------------------------------------------------------------------------
Please use the below steps to deploy the application in a new environment
1. Duplicate the "domain/dev-backend-setup" folder into the new environment folder e.g. 
   staging-backend-setup
2. Change the terraform.tfvars parameters for aws account number (if application is deployed in diff aws 
   account), env name and application name.
3. Create job in the Job Orchestration Tool like jenkins and run the job for provisioning the backend.

4. Duplicate the "domain/dev-codetest" folder into the new environment folder e.g. staging-codetest
5. change the providers.tf file for backend parameters created in step 3. e.g. backend bucket name and   
   state-lock-table name.
6. change the terraform.tfvars for the changed parameters for the new environment. e.g. env name, app name, 
   region name, az names, cidr range for vpc and subnets, asg parameters etc.
7. run the job for deploying the infrastructure in AWS environment. Application is ready for the testing 
   using load balancer url.

Similarly, the application can be deployed in any number of environemnts.

-------------------------------------------------------------------------------------------------------------------
**Please refer to the the "Web Server Infrastructure Provisioning Details.docx" for design details. **
