# Definimos una variable para la IP del nodo master en Kubernetes
variable "master_ip" {
  description = "La dirección IP del master de Kubernetes"
  type        = string
}
