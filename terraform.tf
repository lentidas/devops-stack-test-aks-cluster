terraform {
  # TODO Modify to use Azure as a remote backend
  # backend "azurerm" {
  #   resource_group_name  = "state-file"
  #   storage_account_name = "dstackazstate"
  #   container_name       = "state"
  #   key                  = "tfstate"
  # }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2"
    }
    argocd = {
      source  = "oboukili/argocd"
      version = "~> 6"
    }
  }
}

provider "azurerm" {
  features {}

  tenant_id       = "fc621a41-14f1-4ca5-831e-15c0a062ec75"
  subscription_id = "118c1218-c90c-4c5c-bf1c-b51802b9a986"
}

provider "azuread" {
  tenant_id = "fc621a41-14f1-4ca5-831e-15c0a062ec75"
}

# The providers configurations below depend on the output of some of the modules declared on other *tf files.
# However, for clarity and ease of maintenance we grouped them all together in this section.

provider "kubernetes" {
  host                   = module.aks.kubernetes_host
  username               = module.aks.kubernetes_username
  password               = module.aks.kubernetes_password
  cluster_ca_certificate = module.aks.kubernetes_cluster_ca_certificate
  client_certificate     = module.aks.kubernetes_client_certificate
  client_key             = module.aks.kubernetes_client_key
}

provider "helm" {
  kubernetes {
    host                   = module.aks.kubernetes_host
    username               = module.aks.kubernetes_username
    password               = module.aks.kubernetes_password
    cluster_ca_certificate = module.aks.kubernetes_cluster_ca_certificate
    client_certificate     = module.aks.kubernetes_client_certificate
    client_key             = module.aks.kubernetes_client_key
  }
}

provider "argocd" {
  auth_token                  = module.argocd_bootstrap.argocd_auth_token
  port_forward_with_namespace = module.argocd_bootstrap.argocd_namespace
  insecure                    = true
  plain_text                  = true

  kubernetes {
    host                   = module.aks.kubernetes_host
    username               = module.aks.kubernetes_username
    password               = module.aks.kubernetes_password
    cluster_ca_certificate = module.aks.kubernetes_cluster_ca_certificate
    client_certificate     = module.aks.kubernetes_client_certificate
    client_key             = module.aks.kubernetes_client_key
  }
}
