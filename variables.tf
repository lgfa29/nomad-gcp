# Required.
variable "project" {
  type        = string
  description = "ID do projeto da GCP."
}

# Optional.
variable "region" {
  type        = string
  description = "Região na GCP onde os recursos serão criados."
  default     = "us-central1"
}

variable "zone" {
  type        = string
  description = "Zona na GCP onde os recursos serão criados."
  default     = "us-central1-a"
}

variable "server_count" {
  type        = number
  description = "Número de instâncias para os servidores."
  default     = 3
}

variable "server_instance_type" {
  type        = string
  description = "Tipo de instância usada para os servidores."
  default     = "e2-standard-2"
}

variable "client_count" {
  type        = number
  description = "Número de instâncias para os clientes."
  default     = 2
}

variable "client_instance_type" {
  type        = string
  description = "Tipo de instâncias usadas para os clientes."
  default     = "e2-standard-2"
}
