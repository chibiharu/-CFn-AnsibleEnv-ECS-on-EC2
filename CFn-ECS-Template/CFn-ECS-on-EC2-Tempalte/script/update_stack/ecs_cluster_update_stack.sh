#!/bin/bash

### パラメータ指定 ###
PJPrefix="CFn-ECS-on-EC2"
StackName="${PJPrefix}-ECS-Cluster-Stack"
TempPath="../../template/ecs_cluster.yml"

### スタック作成 ###
aws cloudformation update-stack \
 --stack-name ${StackName} \
 --template-body file://${TempPath} \
 --parameters ParameterKey=PJPrefix,ParameterValue=${PJPrefix} \
 --capabilities CAPABILITY_NAMED_IAM

