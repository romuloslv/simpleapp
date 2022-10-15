data "kubectl_path_documents" "simpleapp" {
  pattern = "./simpleapp/*.yaml"
  vars = {
    docker_image = "romuloslv/simpleapp:1.0"
  }
}

resource "kubectl_manifest" "simpleapp" {
  for_each  = toset(sort(data.kubectl_path_documents.simpleapp.documents))
  yaml_body = each.value

  depends_on = [
    helm_release.kubernetes_dashboard,
    helm_release.ingress-nginx,
    helm_release.prometheus,
    helm_release.grafana,
    helm_release.elasticsearch,
    helm_release.kibana,
    helm_release.dapr
  ]
}