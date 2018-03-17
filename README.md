# terraform-docker-demo

A Terraform configuration to launch a cluster of EC2 instances, fronted by a (classic) elastic load balancer.  Each EC2 instance runs a single nginx Docker container (based on the latest official nginx Docker image).  The load balancer and EC2 instances are launched in a **custom VPC**, and use custom security groups.

Applying the configuration takes about 30 seconds (in US West Oregon), and another two or three minutes for the EC2 instances to become healthy and for the load balancer DNS record to propagate.

## Files
+ `aws.tf` - AWS Provider.
+ `ec2.tf` - Launches EC2 instances, during initialization each instance installs Docker and the nginx Docker image.
+ `elb.tf` - Launches elastic load balancer for EC2 instances running nginx.
+ `vars.tf` - Used by other files, sets default AWS region, calculates availability zones, etc.
+ `vpc.tf` - Launches VPC, subnets, route tables, etc.  **EXTRA CREDIT**  :)

## Access credentials
AWS access credentials must be supplied on the command line (see example below).  This Terraform script was tested in my own AWS account with a user that has the `AmazonEC2FullAccess` and `AmazonVPCFullAccess` policies.  It was also tested in the Splice-supplied AWS account with a user that has the `AdministratorAccess` policy.

## Command Line Examples
To launch the EC2 demo cluster:
```
$ terraform plan -out=aws.tfplan -var "aws_access_key=······" -var "aws_secret_key=······"
$ terraform apply aws.tfplan
```
To teardown the EC2 demo cluster:
```
$ terraform destroy -var "aws_access_key=······" -var "aws_secret_key=······"
```

## URL
Applying this Terraform configuration returns the load balancer's public URL on the last line of output.  This URL can be used to view the default nginx homepage.
