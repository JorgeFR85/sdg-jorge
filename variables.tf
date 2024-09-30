variable "nycmaster_ip" {
  description = "IP nodes master kubernetes"
  type        = string
}

variable "nycworker_ips" {
  description = "IP's nodos"
  type        = list(string)
}
