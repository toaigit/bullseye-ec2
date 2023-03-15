Overview:

You will learn about basic of how to create an EC2 Instance with or without additional filesystem.
   understanding imageID, subnets, security group, zone, ssh-key
   understanding launching configuration
   understanding autoscale - min, max, desired
   understanding userdata (cloud-init), which is executed only during instance created
      You can view the ec2 creation log under /var/log/cloud-init-output.log file
   what is the hostname (DNS)?
   how to login (ssh)?  
      AWS creates an instance with a long unfriendly dns name.
      Use the connect.sh script to connect to the instance without the need of dns friendly name.
   how to add additional filesystem (EBS storage) to the EC2 during the EC2 creation?
      Need to create the EBS volume first.  See the README.first in the ebsvol folder.
   Test out terminate, stop, start and see the IPs and existing files in your HOME
      Touch a file in your home and examing afer etch action (stop, start, terminate)

----------
Your Tasks:
   Defined AWS environment variable (AWS_SECRET_ACCESS_KEY AWS_ACCESS_KEY_ID AWS_DEFAULT_REGION)
   Update the vars.tf with your own values based on your AWS environment.
   Use the awscli.script to find out most of the values you need to update the vars.tf file.
   If you don't have an ssh key in your AWS account yes, please see the NOTEs session on how to.
   Run terraform plan, apply [-auto-approve] to spawn up the ec2.
   Login to your ec2 and validate if the ec2 was created successfully.
      able to sudo su - root
      able to sudo su - appadmin 
      able to run docker ls (as appadmin user)
      check timezone is correctly set
      check if the additional filesystems are mounted. 
      check the /var/log/cloud-init-ouput.log for any errors.
   Don't forget to run terraform destroy in the ebsvol folder as well.

---------
NOTEs:

How to find the ImageID of Oracle, Centos, Debian?
  Search Image by owner:
      Centos Account owner on AWS is 125523088429
      Debian Account owner on AWS is 136693071363
      Oracle Account owner on AWS is 131827586825

How to create ssh-key pair and upload to AWS?
  Use ssh-keygen to create your ssh-key
    ssh-keygen -t rsa -f myaws-keypair -C yourEmail
  Upload to your aws using cli command
    https://docs.aws.amazon.com/cli/latest/reference/ec2/import-key-pair.html OR
    Using Terraform 
    resource "aws_key_pair" "johndoe-keypair" {
       key_name   = "deployer-key"
       public_key = "ssh-rsa AAAAB3...abVohBK41 email@example.com"
     }

How to setup the credential ?
   Before running terraform plan, apply, you need to have your credential environment
   variables defined (AWS_SECRET_ACCESS_KEY AWS_ACCESS_KEY_ID AWS_DEFAULT_REGION)

Security Watchout!
   You should never have your credential or your ssh private key stored in the terraform folders.
