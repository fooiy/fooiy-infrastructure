output ecr_repository_url {
  value       = aws_ecr_repository.ecr_repository.repository_url
  sensitive   = true
  description = "ecr_repository_url"
  depends_on  = []
}

