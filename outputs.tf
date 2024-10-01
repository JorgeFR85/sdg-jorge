# Output para obtener la configuración de Kubernetes
output "kubeconfig" {
  description = "Archivo de configuración de kubeconfig"
  value       = module.kubernetes.kubeconfig
  sensitive   = true
}

# Output para mostrar la IP del nodo master de Kubernetes
output "master_ip" {
  description = "IP del nodo master de Kubernetes"
  value       = module.kubernetes.master_ip
}
