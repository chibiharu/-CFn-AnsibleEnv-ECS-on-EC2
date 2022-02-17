#!/bin/bash

### パラメータ指定 ###
PJPrefix="CFn-ECS-on-Fargate"
StackName="${PJPrefix}-ECS-Service-Stack"
TempPath="../../template/ecs_service.yml"

### スタック作成 ###
aws cloudformation update-stack \
 --stack-name ${StackName} \
 --template-body file://${TempPath} \
 --parameters ParameterKey=PJPrefix,ParameterValue=${PJPrefix} \
 --capabilities CAPABILITY_NAMED_IAM


