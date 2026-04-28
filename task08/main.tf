resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location

  tags = var.tags
}

module "kv" {
  source   = "./modules/keyvault"
  kv_name  = local.keyvault_name
  location = var.location
  rg_name  = azurerm_resource_group.rg.name
  sku_name = var.kv_sku
  tags     = var.tags
}

module "redis" {
  source = "./modules/redis"

  redis_name = local.redis_name
  location   = var.location

  rg_name        = azurerm_resource_group.rg.name
  redis_capacity = var.redis_capacity

  redis_sku_name = var.redis_sku_name
  redis_family   = var.redis_family
  tags           = var.tags

  redis_primary_key_secret_name = var.redis_primary_key_secret_name
  redis_hostname_secret_name    = var.redis_hostname_secret_name

  kv_id = module.kv.kv_id

  depends_on = [module.kv]
}

module "acr" {
  source = "./modules/acr"

  acr_name = var.acr_name
  location = var.location

  rg_name = azurerm_resource_group.rg.name
  acr_sku = var.acr_sku

  repo_url = var.repo_url
  git_pat  = var.git_pat

  image_name = var.docker_image_name

  tags = var.tags

}

module "aci" {
  source = "./modules/aci"

  aci_name = local.aci_name
  location = var.location

  rg_name = azurerm_resource_group.rg.name

  sku_name = var.aci_sku

  tags = var.tags

  ip_type = var.aci_ip_type
  os_type = var.aci_os_type

  acr_login_server = module.acr.acr_login_server
  acr_username     = module.acr.acr_username
  acr_password     = module.acr.acr_password

  docker_image_name = var.docker_image_name

  cpu    = var.aci_cpu
  memory = var.aci_memory

  dns_label_name = var.aci_dns_label


  redis_password = module.redis.redis_primary_key
  redis_url      = module.redis.redis_hostname

  redis_port       = var.redis_port
  redis_ssl_mode   = var.redis_ssl_mode
  application_port = var.application_port

  depends_on = [module.acr]
}

resource "kubectl_manifest" "secret_provider" {
  yaml_body = templatefile("${path.module}/k8s-manifests/secret-provider.yaml.tftpl", {
    aks_kv_access_identity_id  = module.aks.kv_identity_client_id
    kv_name                    = module.keyvault.key_vault_name
    tenant_id                  = data.azurerm_client_config.current.tenant_id
    redis_url_secret_name      = "redis-hostname"
    redis_password_secret_name = "redis-primary-key"
  })

  depends_on = [module.aks, module.redis]
}

resource "kubectl_manifest" "deployment" {
  yaml_body = templatefile("${path.module}/k8s-manifests/deployment.yaml.tftpl", {
    acr_login_server = module.acr.container_registry.login_server
    app_image_name   = local.image_name
    image_tag        = "latest"
  })

  wait_for {
    field {
      key   = "status.availableReplicas"
      value = "1"
    }
  }

  depends_on = [kubectl_manifest.secret_provider, module.acr]
}

resource "kubectl_manifest" "service" {
  yaml_body = file("${path.module}/k8s-manifests/service.yaml")

  wait_for {
    field {
      key        = "status.loadBalancer.ingress.[0].ip"
      value      = "^(\\d+(\\.|$)){4}"
      value_type = "regex"
    }
  }

  depends_on = [kubectl_manifest.deployment]
}

data "kubernetes_service" "app" {
  metadata {
    name      = "redis-flask-app-service"
    namespace = "default"
  }

  depends_on = [kubectl_manifest.service]
}