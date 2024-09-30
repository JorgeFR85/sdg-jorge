output "nycmaster_ip" {
  description = "IP master kubernetes"
  value       = var.master_ip
}

output "kubeconfig" {
  description = "Config conexion cluster"
  value       = "/etc/kubernetes/admin.conf"
  sensitive   = true
}
