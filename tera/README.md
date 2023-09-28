Regarding this terraform implementation
The vpc module is a public module, except the on the terraform repository site is out of date
```source  = "terraform-aws-modules/vpc/aws"```
Are out of date, so I downloaded from github instead

https://github.com/terraform-aws-modules/terraform-aws-vpc/archive/refs/heads/master.zip

The module is referenced in modules/vpc/main.tf