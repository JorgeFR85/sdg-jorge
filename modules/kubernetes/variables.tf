# Definimos una variable para la IP del nodo master en Kubernetes
# Variable para definir el CIDR de la red de pods (Flannel usa 10.244.0.0/16 por defecto)
variable "pod_network_cidr" {
  type    = string
  default = "192.168.2.0/16"
  description = "CIDR para la red de pods en el clúster de Kubernetes"
}

# Variable para definir el complemento de red CNI que se va a utilizar (Flannel por defecto)
variable "cni_plugin" {
  type    = string
  default = "flannel"
  description = "Complemento de red CNI que se instalará (flannel por defecto)"
}

# Variable para definir la versión de Kubernetes que se va a instalar
variable "kubernetes_version" {
  type    = string
  default = "1.31"
  description = "Versión de Kubernetes que se instalará"
}
