# Variable global para definir la IP del master de Kubernetes
variable "master_ip" {
  description = "La dirección IP del master de Kubernetes"
  type        = string
}
variable "worker_ips" {
  description = "Direcciones IP de los workers"
  type        = list(string)
}

