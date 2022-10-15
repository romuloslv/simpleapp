terraform {
  required_version = ">= 1.0.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.40.0"
    }

    kubernetes = {
      source  = "hashicorp/helm"
      version = "2.7.0"
      source  = "hashicorp/kubernetes"
      version = ">= 2.14.0"
    }

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "= 1.14.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }
}

provider "helm" {
  kubernetes {
    host                   = "https://${google_container_cluster._.endpoint}"
    client_certificate     = base64decode(google_container_cluster._.master_auth.0.client_certificate)
    client_key             = base64decode(google_container_cluster._.master_auth.0.client_key)
    cluster_ca_certificate = base64decode(google_container_cluster._.master_auth.0.cluster_ca_certificate)
  }
}

provider "kubernetes" {
  host                   = "https://${google_container_cluster._.endpoint}"
  client_certificate     = base64decode(google_container_cluster._.master_auth.0.client_certificate)
  client_key             = base64decode(google_container_cluster._.master_auth.0.client_key)
  cluster_ca_certificate = base64decode(google_container_cluster._.master_auth.0.cluster_ca_certificate)

}

provider "kubectl" {
  apply_retry_count      = 15
  host                   = "https://${google_container_cluster._.endpoint}"
  client_certificate     = base64decode(google_container_cluster._.master_auth.0.client_certificate)
  client_key             = base64decode(google_container_cluster._.master_auth.0.client_key)
  cluster_ca_certificate = base64decode(google_container_cluster._.master_auth.0.cluster_ca_certificate)
}