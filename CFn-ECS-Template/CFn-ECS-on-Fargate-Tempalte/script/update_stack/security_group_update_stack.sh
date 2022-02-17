#!/bin/bash

### パラメータ指定 ###
PJPrefix="CFn-ECS-on-Fargate"
StackName="${PJPrefix}-Security-Stack"
TempPath="../../template/security_group.yml"

### スタック作成 ###
aws cloudformation update-stack \
 --stack-name ${StackName} \
 --template-body file://${TempPath} \
 --parameters ParameterKey=PJPrefix,ParameterValue=${PJPrefix}
 


