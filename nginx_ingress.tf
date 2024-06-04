resource "kubernetes_namespace" "ingress_nginx" {
  metadata {
    name = "ingress-nginx"
  }
}

resource "kubernetes_deployment" "nginx_ingress_controller" {
  metadata {
    name      = "ingress-nginx-controller"
    namespace = kubernetes_namespace.ingress_nginx.metadata[0].name
    labels = {
      app = "ingress-nginx"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "ingress-nginx"
      }
    }

    template {
      metadata {
        labels = {
          app = "ingress-nginx"
        }
      }

      spec {
        service_account_name = kubernetes_service_account.nginx_ingress_serviceaccount.metadata[0].name
        container {
          name  = "controller"
          image = "k8s.gcr.io/ingress-nginx/controller:v1.10.0"

          args = [
            "/nginx-ingress-controller",
            "--configmap=$(POD_NAMESPACE)/nginx-configuration",
            "--tcp-services-configmap=$(POD_NAMESPACE)/tcp-services",
            "--udp-services-configmap=$(POD_NAMESPACE)/udp-services",
            "--annotations-prefix=nginx.ingress.kubernetes.io"
          ]

          port {
            name           = "http"
            container_port = 80
          }

          port {
            name           = "https"
            container_port = 443
          }

          env {
            name = "POD_NAME"
            value_from {
              field_ref {
                field_path = "metadata.name"
              }
            }
          }

          env {
            name = "POD_NAMESPACE"
            value_from {
              field_ref {
                field_path = "metadata.namespace"
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "nginx_ingress" {
  metadata {
    name      = "ingress-nginx-controller"
    namespace = kubernetes_namespace.ingress_nginx.metadata[0].name
  }

  spec {
    type = "LoadBalancer"

    selector = {
      app = "ingress-nginx"
    }

    port {
      name        = "http"
      port        = 80
      target_port = 80
    }

    port {
      name        = "https"
      port        = 443
      target_port = 443
    }
  }
}

resource "kubernetes_cluster_role" "nginx_ingress_role" {
  metadata {
    name = "nginx-ingress-role"
  }

  rule {
    api_groups = [""]
    resources  = ["services", "endpoints", "configmaps", "secrets", "pods"]
    verbs      = ["get", "list", "watch"]
  }
  rule {
    api_groups = ["networking.k8s.io"]
    resources  = ["ingresses", "ingresses/status"]
    verbs      = ["get", "list", "watch", "update"]
  }
  rule {
    api_groups = ["coordination.k8s.io"]
    resources  = ["leases"]
    verbs      = ["get", "list", "watch", "create", "update"]
  }
  rule {
    api_groups = ["discovery.k8s.io"]
    resources  = ["endpointslices"]
    verbs      = ["get", "list", "watch"]
  }
}


resource "kubernetes_service_account" "nginx_ingress_serviceaccount" {
  metadata {
    name      = "nginx-ingress-serviceaccount"
    namespace = kubernetes_namespace.ingress_nginx.metadata[0].name
  }
}

resource "kubernetes_cluster_role_binding" "nginx_ingress_role_binding" {
  metadata {
    name = "nginx-ingress-role-binding"
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.nginx_ingress_serviceaccount.metadata[0].name
    namespace = kubernetes_namespace.ingress_nginx.metadata[0].name
  }

  role_ref {
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.nginx_ingress_role.metadata[0].name
    api_group = "rbac.authorization.k8s.io"
  }
}
