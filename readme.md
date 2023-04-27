# AWS Cloud Architecture Project

## Index

- [Introduction](#introduction)
- [Requirements](#requirements)
- [Architecture](#architecture)
- [Implementation](#implementation)
- [Conclusion](#conclusion)

## Introduction
For this project, I designed and implemented a virtual private cloud (VPC) with a webserver, following specific requirements. The VPC includes four subnets evenly distributed across two availability zones, with two public subnets connected to an internet gateway and two private subnets connected to a NAT gateway. I also configured network access control lists (NACLs), security groups, and flow logs to monitor web traffic. The webserver hosts an HTTP website that displays the EC2 instance's status, and I conducted a stress test to verify its functionality.

Before we begin, it's important to note that certain aspects of this lab are confidential (thus some information may be ommited) as they were provided by the AWS re/Start program. This includes the virtual lab environment, webpage template, and project guidelines. While this guide is not meant to be a comprehensive solution, I will share my own insights and additional requirements to make the lab more challenging.
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
- EC2 instance will host the webserver. User data scripts will install, configure, and update the Linux operating system and install the webserver.

When properly implementing all the required architecture, the VPC should look something like this:
![awsarchitecture](https://user-images.githubusercontent.com/128739036/234729367-e90d0fb4-70a7-4875-bc0d-0c590e59b2cc.png)

## Implementation
What made this project interesting was the fact that each service had to be manually configured. While there are options available to automatically set up a robust VPC capable of hosting a simple yet secure web server, the ability to create more complex architecture from scratch is an important skill that many overlook. By mastering these fundamentals, I have developed a deeper understanding of how AWS services work together, which will undoubtedly strengthen my future applications of these skills even further, especially when utilizing the shortcuts and presets that AWS has to offer.
### Creating the VPC
It's important to note that when creating a VPC without the use of the "VPC and more" option, the number of available IP addresses doesn't appear when setting the IPv4 CIDR. This is also true when configuring the CIDR block for subnets; you can't see the number of IP addresses in each subnet until after creation. Without a fundamental understanding of how IP addresses and slash notation work, including their differences and implementations in AWS, one may struggle to properly configure a VPC with the correct number of IP addresses for a specific use case.Thankfully, this project already specifies the required CIDR notation for the VPC and all four subnets.

I highly recommend using tools like [IP Subnet Calculator](https://www.calculator.net/ip-subnet-calculator.html) or [cidr.xyz](https://cidr.xyz/) to visualize the available options and gain a better understanding of your network.

The "Resource Map" feature is an invaluable tool for managing and configuring your VPC, especially when setting it up manually like in this project. With this tool, you can easily visualize and edit the various components of your VPC, such as routing tables, subnets, and gateways, to ensure that they are linked up correctly according to the project requirements. This can save a lot of time and headache compared to manually associating subnets with routing tables and gateways. Although the resource map has some limitations, such as the inability to see the exact subnet of a NAT gateway or reorder items for better organization, it still streamlines VPC management and represents a step forward in automatic cloud architecture diagrams.
![resourcemapexample](https://user-images.githubusercontent.com/128739036/234737168-384bc76d-8508-4316-90a9-e5fc0978ee9b.png)

While I won't delve into the security configuration of this project in detail, I encourage you to check out my other Github repository where I explore various AWS security features including best practices, encryption, IAM, and more. In this project, I configured the bare minimum for security groups since I was the only one accessing the webserver. With only one instance, securing the setup was relatively straightforward.
### Launching the Webserver

