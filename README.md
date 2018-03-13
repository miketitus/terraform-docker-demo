# terraform-docker-demo

A Terraform script to launch a cluster of EC2 instances, fronted by a (classic) elastic load balancer.  Each EC2 instance runs a single nginx Docker container (based on the latest official nginx Docker image).

## Access credentials
AWS access credentials must be supplied on the command line (see example below).  This Terraform script was tested in my own AWS account with a user that has the `AmazonEC2FullAccess` policy.  It was also tested in the Splice-supplied AWS account with a user that has the `AdministratorAccess` policy.

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
The default nginx homepage can be viewed at http://splice-demo-elb-564546257.us-west-2.elb.amazonaws.com/
