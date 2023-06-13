#!/bin/bash
cd terraform
terraform plan -destroy -out main.destroy.tfplan
terraform apply main.destroy.tfplan
cd ..
