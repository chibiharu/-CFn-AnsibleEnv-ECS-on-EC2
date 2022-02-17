#!/bin/bash

### パラメータ指定 ###
PJPrefix="cdev"
StackName="${PJPrefix}-Route53-Stack"
TempPath="../../template/route53.yml"

### スタック作成 ###
aws cloudformation update-stack \
 --stack-name ${StackName} \
 --template-body file://${TempPath} \
 --parameters ParameterKey=PJPrefix,ParameterValue=${PJPrefix} \


