#!/bin/bash

### パラメータ指定 ###
PJPrefix="cdev"
StackName="${PJPrefix}-Server-Stack"
TempPath="../../template/server.yml"

### スタック作成 ###
aws cloudformation create-stack \
 --stack-name ${StackName} \
 --template-body file://${TempPath} \
 --parameters ParameterKey=PJPrefix,ParameterValue=${PJPrefix} \
 --capabilities CAPABILITY_NAMED_IAM

