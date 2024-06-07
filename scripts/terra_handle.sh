# terraform initialize with backend s3 in cli
terraform init \
  -backend-config="bucket=terraform-state-bucket" \
    -backend-config="key=terraform.tfstate" \
      -backend-config="region=us-east-1"

# terraform plan in cli
terraform plan 

# terraform apply in cli
terraform apply -auto-approve