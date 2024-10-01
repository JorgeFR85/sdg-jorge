# Output para mostrar la IP del nodo master de Kubernetes
output "master_ip" {
  description = "IP del nodo master de Kubernetes"
  value       = module.kubernetes.master_ip
}
