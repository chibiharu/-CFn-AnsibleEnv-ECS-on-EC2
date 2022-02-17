#!/bin/bash

### パラメータ指定 ###
PJPrefix="CFn-ECS-on-EC2"
StackName="${PJPrefix}-ECR-Stack"
TempPath="../../template/ecr.yml"

### スタック作成 ###
aws cloudformation update-stack \
 --stack-name ${StackName} \
 --template-body file://${TempPath} 