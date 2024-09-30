variable "master_ip" {
  description = "IP del nodo maestro"
  type        = string
}

variable "worker_ips" {
  description = "Lista de IPs de los nodos trabajadores"
  type        = list(string)
}
