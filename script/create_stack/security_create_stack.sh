#!/bin/bash

### パラメータ指定 ###
PJPrefix="cdev"
StackName="${PJPrefix}-Security-Stack"
TempPath="../../template/security.yml"

### スタック作成 ###
aws cloudformation create-stack \
 --stack-name ${StackName} \
 --template-body file://${TempPath} \
 --parameters ParameterKey=PJPrefix,ParameterValue=${PJPrefix} \


