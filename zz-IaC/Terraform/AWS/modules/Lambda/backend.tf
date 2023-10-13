#terraform {
# Uncomment and configure the following block to use an S3 backend for Terraform state storage

# terraform {
#   backend "s3" {
#     bucket         = "your-unique-s3-bucket-name"
#     key            = "terraform.tfstate"
#     region         = "us-east-1" # Change to your desired AWS region
#     encrypt        = true
#     acl            = "private" # Set to "private" for secure access control
#     dynamodb_table = "your-lock-table-name" # Optional: Use DynamoDB for state locking
#   }
# }
