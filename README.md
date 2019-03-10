## 0.0.0.0 - ELB - ASG test task

In this test task Terraform the code implemented which deploys an EC2 instance that
running within ASG with ELB in front of it. This instance, through *classic* ELB,
shares port 22 (SSH, configurable in Terraform, but was not for sshd) to the Internet.

This creates two security groups, a launch configuration, an auto scaling group and an ELB.
The user data for launch configuration does nothing.

The example uses *ubuntu-trusty-14.04 (x64)* AMI.

*us-east-1* AWS region is used.

To run, [configure your AWS provider](https://www.terraform.io/docs/providers/aws/index.html)

## Running the example

### For planning phase 

```
terraform plan
```

### For apply phase

```
terraform apply
```
Once the stack is created, wait for few minutes and test the stack by any ssh client.
Access to the instance should be available only throw ELB.

### To remove the stack

```
 terraform destroy
```

## Source
This implemtation is based on [Terraform Provider AWS. ASG Example](https://github.com/terraform-providers/terraform-provider-aws/tree/master/examples/asg)
