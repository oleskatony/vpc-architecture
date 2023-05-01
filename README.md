# AWS Cloud Architecture Project

## Index

- [Introduction](#introduction)
- [Requirements](#requirements)
- [Architecture](#architecture)
- [Implementation](#implementation)
- [Conclusion](#conclusion)

## Introduction
For this project, I designed and implemented a virtual private cloud (VPC) with a webserver, following specific requirements. The VPC includes four subnets evenly distributed across two availability zones, with two public subnets connected to an internet gateway and two private subnets connected to a NAT gateway. I also configured network access control lists (NACLs), security groups, and flow logs to monitor web traffic. The webserver hosts an HTTP website that displays the EC2 instance's status, and I conducted a stress test to verify its functionality.

Before we begin, it's important to note that certain aspects of this lab are confidential (thus some information may be ommited) as they were provided by the AWS re/Start program. This includes the virtual lab environment, webpage template, and project guidelines. While this documentation is not meant to be a comprehensive walkthrough for this project, I do want to express some of the key takeaways I found while developing this architecture. I also have added a few additional requirements to make the lab more challenging.
## Requirements
These were the following skills needed to properly configure the VPC and webserver with the given guidelines:

- Creating and configuring a VPC with subnets, routing tables, internet gateways, and NAT gateways.
- Configuring flow logs, NACL rules, and best practice architectural decision making when building a VPC.
- Creating an S3 bucket with an optimal security configuration to store flow logs.
- Configuring network settings and security groups for EC2 instances, and using user data scripts to install and configure the Linux operating system.
## Architecture
The specific requirements of the projects were as follows:
- The VPC must be created from scatch without the use of the "VPC and more" feature, The VPC must have a private IP range of 10.0.0.0/16.
- The VPC should have four subnets, with two public and two private subnets distributed evenly across two availability zones. Each subnet should have a /24 CIDR.
- The public subnets should be on one routing table connected to an internet gateway, while the private subnets should be on a separate routing table connected to a NAT gateway located on one of the public subnets.
- Flow logs need to be configured to monitor and send web traffic to a S3 bucket.
- Security groups will be configured only allow for http and https traffic.
- EC2 instance will host the webserver. User data scripts will install, configure, and enable the webserver.

When properly implementing all the required architecture, the VPC should look something like this:
![awsarchitecture](https://user-images.githubusercontent.com/128739036/234729367-e90d0fb4-70a7-4875-bc0d-0c590e59b2cc.png)

## Implementation
In this project, I had the opportunity to manually configure each service in AWS, which made it a unique and challenging experience. While there are options available to automatically set up a robust VPC capable of hosting a simple yet secure web server, I found that manually creating a more complex architecture from scratch was an important skill that many overlook. By mastering these fundamentals, I was able to develop a deeper understanding of how AWS services work together, which will undoubtedly strengthen my future applications of these skills even further, especially when utilizing the shortcuts and presets that AWS has to offer.
### Creating the VPC
It's important to note that when creating a VPC without the use of the "VPC and more" option, the number of available IP addresses doesn't appear when setting the IPv4 CIDR. This is also true when configuring the CIDR block for subnets; you can't see the number of IP addresses in each subnet until after creation. Without a fundamental understanding of how IP addresses and slash notation work, including their differences and implementations in AWS, one may struggle to properly configure a VPC with the correct number of IP addresses for a specific use case.Thankfully, this project already specifies the required CIDR notation for the VPC and all four subnets.

I highly recommend using tools like [IP Subnet Calculator](https://www.calculator.net/ip-subnet-calculator.html) or [cidr.xyz](https://cidr.xyz/) to visualize the available options and gain a better understanding of your network.

The "Resource Map" feature is an invaluable tool for managing and configuring your VPC, especially when setting it up manually like in this project. With this tool, you can easily visualize and edit the various components of your VPC, such as routing tables, subnets, and gateways, to ensure that they are linked up correctly according to the project requirements. This can save a lot of time and headache compared to manually associating subnets with routing tables and gateways. Although the resource map has some limitations, such as the inability to see the exact subnet of a NAT gateway or reorder items for better organization, it still streamlines VPC management and represents a step forward in automatic cloud architecture diagrams.
![resourcemapexample](https://user-images.githubusercontent.com/128739036/234737168-384bc76d-8508-4316-90a9-e5fc0978ee9b.png)
Quickly creating an S3 bucket for the flow logs of this VPC is pretty straightforward as there were no restrictions regarding the bucket for this project. No versioning or special bucket policies were needed other than double-checking that public access was disabled. Speaking of security...

I won't delve too deep into the security configuration of this project in detail, but I encourage you to check out my [security repository](https://github.com/oleskatony/security) where I explore various AWS security features including best practices, encryption with KMS, IAM, and more. In this project, I configured the bare minimum for security groups since I was the only one accessing the webserver. With only one instance, securing the setup was relatively straightforward.
### Launching the Webserver
After having a fully configured VPC, the only thing left was to set up an EC2 in the correct subnet with userdata set to automaticly configure the webserver with minimal effort. As long as your aware of what VPC and subnet you are putting the instance in, there shouldnt be any problems. The project provided the template for the webpage and script to install and start up the webserver, but I ended up just making my own simple script with that would work a bit better with newer Red Hat-based Linux distributions, such as CentOS 7 and later. I also ensured to use the .service prefix to make sure that older versions of systemctl would work with this script.

```bash
#!/bin/bash
# Install Apache Web Server and PHP
yum install -y httpd php
# Download lab files
wget "url to lab-app.zip"
unzip lab-app.zip -d /var/www/html/
# Turn on web server
systemctl enable httpd.service
systemctl start httpd.service
```
Upon visiting the public IP address of the EC2 instance, it was confirmed that the script had been successful. I also verified that the previously configured flow logs accurately monitored web traffic.

## Conclusion
After completing this project, I was left with a solid foundation to further experiment with AWS. I was particularly interested in testing the limitations of the enviroment created for this project by placing EC2 instances in different subnets, each with different security settings. Using PuTTY, I was able to connect to each instance and perform various tests, tweaking security settings and VPC configurations along the way. I also found myself frequently checking the flow logs to gain a better understanding of the effects of my sandboxing. Overall, this project has opened up exciting possibilities for future exploration and experimentation.

In conclusion, this project provided me with the opportunity to master the fundamental skills of manually configuring each service in AWS, which was a unique and challenging experience. While there are options available to automatically set up a robust VPC capable of hosting a simple yet secure web server, I found that manually creating a more complex architecture from scratch was an important skill that many overlook. By developing a deeper understanding of how AWS services work together, I can confidently apply these skills in the future, especially when utilizing the shortcuts and presets that AWS has to offer.
