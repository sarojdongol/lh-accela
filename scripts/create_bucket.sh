# Creates s3 bucket to store terraform state files
#!/usr/bin/env bash
set -e
bucket_name=$1
region=$2

aws s3api create-bucket --bucket $bucket_name --region $2 --create-bucket-configuration LocationConstraint=$2

