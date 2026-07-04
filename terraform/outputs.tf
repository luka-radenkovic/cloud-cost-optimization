output "s3_bucket_name" {
  description = "Naziv kreiranog S3 bucket-a."
  value       = aws_s3_bucket.project_storage.bucket
}

output "app_server_instance_type" {
  description = "Tip instance za aplikacioni server."
  value       = aws_instance.app_server.instance_type
}

output "worker_server_instance_type" {
  description = "Tip instance za worker server."
  value       = aws_instance.worker_server.instance_type
}