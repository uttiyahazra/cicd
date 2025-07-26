resource "kubernetes_deployment" "deployment" {
  metadata {
    name      = var.app_name
    namespace = var.namespace_name
  }
  spec {
    replicas = var.replica

    selector {
      match_labels = {
        app = var.app_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.app_name
        }
      }
      spec {
        container {
          image = "nginx:latest"
          name  = "${var.app_name}-container"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "service" {
  metadata {
    name      = "${var.app_name}-service"
    namespace = var.namespace_name
  }
  spec {
    selector = {
      app = var.app_name
    }
    port {
      port        = 80
      target_port = 80
    }
    type = "ClusterIP"
  }
}
