#!/usr/bin/env bash
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text --profile default)
AWS_REGION=$(aws configure get region --profile default)

SOURCE_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}) && pwd)
cd ${SOURCE_DIR}

function deploy(){
    aws cloudformation deploy \
        --template-file $1 \
        --stack-name $2 \
        --capabilities CAPABILITY_NAMED_IAM \
	--profile default
}


case "$1" in
    "network")deploy network.yml Network;;
    "cluster")deploy cluster.yml Cluster;;
    "nodes")deploy nodes.yml Nodes;;
esac
