#!/bin/bash

### パラメータ指定 ###
PJPrefix="CFn-ECS-on-Fargate"
StackName="${PJPrefix}-ALB-Stack"
TempPath="../../template/alb.yml"

### スタック作成 ###
aws cloudformation create-stack \
 --stack-name ${StackName} \
 --template-body file://${TempPath} \
 --parameters ParameterKey=PJPrefix,ParameterValue=${PJPrefix} \


