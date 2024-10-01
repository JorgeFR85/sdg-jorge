variable "master_ip" {
  description = "IP nodes master kubernetes"
  type        = string
}

variable "worker_ips" {
  description = "IP's nodos"
  type        = list(string)
}
