# Web Application Terraform Module for OCI

This is a simple terraform module that creates infrastructure for three tier web application in Oracle cloud. It creates VCN, 2 subnets along with Route Tables, Network Security Groups, and optional bastion server, webserver instance and a database.

![Web Application Architecture](.\docs\architecture.png)


### How to use this Module

This repo contains 3 terraform modules - Network, Database and Webserver. They are all invoked from main.tf in root folder.

To deploy the infrastructure:
1. set environment variables in `tfenv.cmd`
2. set attributes for individual modules in `terraform.tfvars`
3. run `terraform init`, followed by `terraform plan` and `terraform apply`
