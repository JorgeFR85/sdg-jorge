# Este output devuelve la IP del nodo master
# Output para devolver la ruta del archivo de configuración de Kubernetes (kubectl)
output "kube_config_path" {
  description = "Ruta al archivo de configuración de Kubernetes (kubectl)."
  value       = "$HOME/.kube/config"
}

# Output para devolver el CIDR de la red de pods configurada
output "pod_network_cidr" {
  description = "CIDR de la red de pods configurada para el clúster de Kubernetes."
  value       = var.pod_network_cidr
}

# Output para devolver la versión de Kubernetes instalada
output "kubernetes_version" {
  description = "Versión de Kubernetes instalada en el clúster."
  value       = var.kubernetes_version
}
