locals {
  resource_group_name = "rg-${var.project_code}-${var.environment}-${var.instance}"

  # common_tags = merge(var.tags, {
  #   Environment = var.environment
  #   ManagedBy   = "terraform"
  # })
}

# rg-aedp-dev-001