# VPC Definition
resource "aws_vpc" "bookhub_vpc" {
  cidr_block = "10.0.0.0/16"
}

# Subnet Definition with Unique CIDR Blocks
resource "aws_subnet" "bookhub_subnet" {
  count             = 2
  vpc_id            = aws_vpc.bookhub_vpc.id
  cidr_block        = "10.0.${count.index + 1}.0/24"  # Unique CIDR for each subnet
  availability_zone = "us-east-1a"   # Distribute subnets across different availability zones
}

# Security Group Definition
resource "aws_security_group" "bookhub_sg" {
  vpc_id = aws_vpc.bookhub_vpc.id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# S3 Bucket Configuration
resource "aws_s3_bucket" "bookhub_bucket" {
  bucket = "bookhub-s3-bucket"
}

# DynamoDB Table for Books
resource "aws_dynamodb_table" "bookhub_books" {
  name           = "bookhub_books"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "book_id"
  
  attribute {
    name = "book_id"
    type = "S"
  }
}

# DynamoDB Table for Reviews
resource "aws_dynamodb_table" "bookhub_reviews" {
  name           = "bookhub_reviews"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "review_id"
  
  attribute {
    name = "review_id"
    type = "S"
  }
}

# SNS Topic for Notifications
resource "aws_sns_topic" "bookhub_topic" {
  name = "bookhub_notifications"
}

# SNS Topic Subscription for Email
resource "aws_sns_topic_subscription" "bookhub_email_subscription" {
  topic_arn = aws_sns_topic.bookhub_topic.arn
  protocol  = "email"
  endpoint  = "user@example.com"  # Replace with actual user emails
}

# SQS Queue for Background Task Processing
resource "aws_sqs_queue" "bookhub_queue" {
  name = "bookhub_task_queue"
}
