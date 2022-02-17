#!/bin/bash

### パラメータ指定 ###
PJPrefix="cdev"
StackName="${PJPrefix}-ECS-Cluster-Stack"
TempPath="../../template/ecs_cluster.yml"

### スタック作成 ###
aws cloudformation create-stack \
 --stack-name ${StackName} \
 --template-body file://${TempPath} \
 --parameters ParameterKey=PJPrefix,ParameterValue=${PJPrefix} \
 --capabilities CAPABILITY_NAMED_IAM

