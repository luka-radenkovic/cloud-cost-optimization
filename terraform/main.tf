resource "aws_s3_bucket" "project_storage" {
  bucket = "${var.project_name}-storage-demo"

  tags = {
    Name        = "${var.project_name}-storage"
    Environment = "Dev"
    Project     = var.project_name
    Service     = "app"
  }
}

resource "aws_instance" "app_server" {
  ami                         = var.ami_id
  instance_type               = var.app_instance_type
  associate_public_ip_address = false


  root_block_device {
    volume_size = 20
    volume_type = "gp3"
    tags = {
      Name        = "${var.project_name}-app-server-root"
      Environment = var.environment
      Project     = var.project_name
      Service     = "app"
    }
  }

  tags = {
    Name        = "${var.project_name}-app-server"
    Environment = "Dev"
    Project     = var.project_name
    Service     = "app"
  }
}

resource "aws_instance" "worker_server" {
  ami                         = var.ami_id
  instance_type               = var.worker_instance_type
  associate_public_ip_address = false

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
    tags = {
      Name        = "${var.project_name}-worker-server-root"
      Environment = var.environment
      Project     = var.project_name
      Service     = "worker"
    }
  }

  tags = {
    Name        = "${var.project_name}-worker-server"
    Environment = "Dev"
    Project     = var.project_name
    Service     = "worker"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "project_storage_lifecycle" {
  bucket = aws_s3_bucket.project_storage.id

  rule {
    id     = "abort-incomplete-multipart-uploads"
    status = "Enabled"

    filter {}

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }

  rule {
    id     = "transition-to-cheaper-storage"
    status = "Enabled"

    filter {}

    transition {
      days          = 30
      storage_class = "INTELLIGENT_TIERING"
    }
  }
}

resource "aws_s3_bucket_policy" "project_storage_ssl_only" {
  bucket = aws_s3_bucket.project_storage.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "DenyInsecureTransport"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          aws_s3_bucket.project_storage.arn,
          "${aws_s3_bucket.project_storage.arn}/*"
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      }
    ]
  })
}
