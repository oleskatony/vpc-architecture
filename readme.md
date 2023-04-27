# AWS Cloud Architecture Example

## Index

- [Introduction](#introduction)
- [Requirements](#requirements)
- [Architecture](#architecture)
- [Implementation](#implementation)
- [Conclusion](#conclusion)

## Introduction
For this project, I designed and implemented a virtual private cloud (VPC) with a webserver, following specific requirements. The VPC includes four subnets evenly distributed across two availability zones, with two public subnets connected to an internet gateway and two private subnets connected to a NAT gateway. I also configured network access control lists (NACLs), security groups, and flow logs to monitor web traffic. The webserver hosts an HTTP website that displays the EC2 instance's status, and I conducted a stress test to verify its functionality.
## Requirements
These were the following skills needed to properly configure the VPC and webserver with the given guidelines:

-Creating and configuring a VPC with subnets, routing tables, internet gateways, and NAT gateways.
-Configuring flow logs, NACL rules, and best practice architectural decision making when building a VPC.
-Creating an S3 bucket with an optimal security configuration to store flow logs.
-Configuring network settings and security groups for EC2 instances, and using user data scripts to install and configure the Linux operating system.
## Architecture
([awsarchitecture.png](https://i.imgur.com/YtNFE2t.png))
