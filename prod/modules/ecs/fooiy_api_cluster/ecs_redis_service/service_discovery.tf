resource "aws_service_discovery_service" "fooiy-api-redis" {
  name = "fooiy-api-redis"
  dns_config {
    namespace_id   = var.ecs_service_discovery_zone_id
    routing_policy = "MULTIVALUE"

    dns_records {
      ttl  = 10
      type = "A"
    }
  }
  health_check_custom_config {
    failure_threshold = 5
  }
}

