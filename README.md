# project2
terraform scripts for automating aws services 
#### there are a total of 8 terraform scripts for automating aws services
1st. key_pair.tf script it generates key pair to do safe ssh into the the ec2 instance
2nd. security_group.tf it generates security group it have 3 inbound rules , called ingress rules in terrafrom scripts 
3rd. ec2.tf it generates the ec2 instance with ami ubuntu and instance type t2.micro and uses the key pair and security group created above
4th. ami_from_instance.tf it generates the ami image of the ec2 instance created you can see it in my amis
5th. template_from_image.tf it generates the template using the ami created ,very good technique for using the instance which is used again and again for deployment
6th. target_group_for_lb.tf it generates the target group to check if the instance is in healthy state or not
7th. load_balancer_from_template.tf it generates a load balancer of type applocation using the template created and using the target group created ,it also creates a autoscaling group which launches 2 ec2 at max and min 1 on cpu utilization over 60%
8th.s3_bucket.tf it generates the s3 bucket for storing important files

##### i have also attached a points_to_remeber.txt file in which all commands and prerequistes are mentioned for launching all services 

##### i have made comments in each file so that one using can easily make their own changes in the files and also a breif comments are also left for what key module does what 

##### i have taken help from terrafrom documents from which i have selected modules for launching these services 
