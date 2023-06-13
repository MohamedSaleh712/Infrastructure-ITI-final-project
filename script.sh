#!/bin/bash

cd ./terraform
terraform init 
terraform fmt 
terraform validate 
terraform apply --auto-approve

aws eks update-kubeconfig --region us-east-1 --name eks-iti-final-project --profile terraform-user
sleep 10
kubectl apply -f ../jenkins-deployment/jenkins-namespace.yaml
kubectl apply -f ../jenkins-deployment/jenkins-service-account.yaml
kubectl apply -f ../jenkins-deployment/jenkins-pv-pvc.yaml
kubectl apply -f ../jenkins-deployment/jenkins-service.yaml
kubectl apply -f ../jenkins-deployment/jenkins-deploy.yaml


