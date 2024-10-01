# Este output devuelve la IP del nodo master
output "master_ip" {
  description = "IP del nodo master de Kubernetes"
  value       = var.master_ip
}
