#

**15:58** - Init this test git repository

**16:00** - AWS Account registration

**16:10** - Terraform introduction
- [x] https://www.google.com/search?q=terraform
- [x] https://www.terraform.io/
- [x] https://www.terraform.io/intro/index.html

**16:13** - Installing (https://learn.hashicorp.com/terraform/getting-started/install.html)
- [x] https://www.terraform.io/downloads.html

```
mkdir tmp
mv terraform_0.11.12_linux_amd64.zip tmp/
cd tmp
unzip terraform_0.11.12_linux_amd64.zip

16:17@debian .../npe/tmp$ ./terraform -version
 Terraform v0.11.12

```

```
mv terraform ../
cd ..
rm -rf tmp
```

**16:23** - mail from AWS about created account
- [x] Logged in
- [x] Creating non-root user with only a 'Programmatic access' to test the terraform configuration
- [x] At beggining to avoid time spending for user access and permissions boundary configuration
- [x] the 'Administrators' group with full access created for the user and no any permissions
- [x] boundary created.

**16:30** - saving user AWS credentials in a proper place ;)
- [x] user access testing
```
16:46@debian .../sites/npe$ aws --profile npe sts get-caller-identity
{
- [x] "Account": "123456789012",
- [x] "UserId": "AIDXXXXXXXXXXXXXXXXXXX",
- [x] "Arn": "arn:aws:iam::123456789012:user/npe"
}
```

- [x] weekend :) pause for childcare.

**17:47** - continue with Terraform introduction
	https://www.terraform.io/intro/examples/index.html
- [x] https://www.terraform.io/intro/examples/aws.html
	https://github.com/terraform-providers/terraform-provider-aws/tree/master/examples/two-tier

	git clone https://github.com/terraform-providers/terraform-provider-aws.git

**17:45** - configure the AWS provider as described in
	https://www.terraform.io/docs/providers/aws/index.html

- [x] 'Shared Credentials file' will be used

```
17:46@debian .../sites/npe$ ./terraform plan

 Error: No configuration files found!
 ...
```

	the example git repository has a folder 'examples/asg'. I hope it will be enough to just
	clarify this example to solve this test task.

```
17:53@debian .../sites/npe$ cp -v terraform-provider-aws/examples/asg/* ./
'terraform-provider-aws/examples/asg/README.md' -> './README.md'
'terraform-provider-aws/examples/asg/main.tf' -> './main.tf'
'terraform-provider-aws/examples/asg/outputs.tf' -> './outputs.tf'
'terraform-provider-aws/examples/asg/userdata.sh' -> './userdata.sh'
'terraform-provider-aws/examples/asg/variables.tf' -> './variables.tf'
```

```
17:48@debian .../sites/npe$ ./terraform plan
Plugin reinitialization required. Please run "terraform init".
Reason: Could not satisfy plugin requirements.
...
```

```
17:48@debian .../sites/npe$ ./terraform init

Initializing provider plugins...
- Checking for available provider plugins on https://releases.hashicorp.com...
- Downloading plugin for provider "aws" (2.1.0)...
...
* provider.aws: version = "~> 2.1"

Terraform has been successfully initialized!
...
```

```
18:02@debian .../sites/npe$ ./terraform plan
var.key_name
  Name of AWS key pair
...
```

**18:02** - the configiuration clarification and terraform plan & apply action testing

**18:39** - completing AWS registration

**18:43** - continue with the test task

**19:11** - the test example configuration applied
- [x] the ubuntu server public IP - X.X.X.X. Port 80 is accessable
- [x] the ELB domain terraform-example-elb-123456789012.us-east-1.elb.amazonaws.com.
- [x]     Port 80 is accessable

**19:15** - real configuration
- [x] see details in commits

**21:24** - clear environment & last start test
**21:41** - + notification about classic ELB available ports


**21:45** - github repository creation
- [x] README.md finalization

**22:26** - this file is finished.
