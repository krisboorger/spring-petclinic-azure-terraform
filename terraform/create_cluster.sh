#!/bin/bash
terraform plan -out main.tfplan
terraform apply main.tfplan
