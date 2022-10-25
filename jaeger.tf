resource "kubectl_manifest" "jaeger" {
  yaml_body = templatefile("${path.module}/templates/jaeger_values.yaml", {})

  depends_on = [
    helm_release.kubernetes_dashboard,
    helm_release.ingress-nginx,
    helm_release.prometheus,
    helm_release.grafana,
    helm_release.elasticsearch,
    helm_release.kibana,
    helm_release.dapr,
    helm_release.jaeger_operator
  ]
}

resource "kubectl_manifest" "jaeger_frontend" {
  yaml_body = templatefile("${path.module}/jaegerapp/frontend/jaeger-frontend.yaml", {})

  depends_on = [
    helm_release.kubernetes_dashboard,
    helm_release.ingress-nginx,
    helm_release.prometheus,
    helm_release.grafana,
    helm_release.elasticsearch,
    helm_release.kibana,
    helm_release.dapr,
    helm_release.jaeger_operator
  ]
}

data "kubectl_path_documents" "jaeger_backend" {
  pattern = "./jaegerapp/backend/*.yaml"
  vars    = { docker_image = "romuloslv/backend:1.0" }
}

resource "kubectl_manifest" "jaeger_backend" {
  for_each  = toset(sort(data.kubectl_path_documents.jaeger_backend.documents))
  yaml_body = each.value

  depends_on = [
    helm_release.kubernetes_dashboard,
    helm_release.ingress-nginx,
    helm_release.prometheus,
    helm_release.grafana,
    helm_release.elasticsearch,
    helm_release.kibana,
    helm_release.dapr,
    helm_release.jaeger_operator
  ]
}