locals {
  rg_name    = join("-", [var.name_prefix, "rg"])
  redis_name = join("-", [var.name_prefix, "redis"])
  kv_name    = join("-", [var.name_prefix, "kv"])
  aci_name   = join("-", [var.name_prefix, "ci"])
  aks_name   = join("-", [var.name_prefix, "aks"])

}