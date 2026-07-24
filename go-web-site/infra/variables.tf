variable "location" {
  type        = string
  default     = "westeurope"
  description = "Регион Azure"
}

variable "resource_group_name" {
  type        = string
  default     = "rg-go-web-app"
  description = "Имя группы ресурсов"
}

variable "container_group_name" {
  type        = string
  default     = "aci-go-web-app"
  description = "Имя Container Group"
}

variable "dns_name_label" {
  type        = string
  default     = "go-web-app-unique-dns" # Должно быть уникальным в пределах региона Azure
  description = "DNS префикс для публичного IP"
}

variable "container_name" {
  type        = string
  default     = "go-web-app"
  description = "Имя контейнера внутри группы"
}

variable "container_image" {
  type        = string
  default     = "ghcr.io/hamka-123/go-web-app:sha-34c9c3c@sha256:52b588e0915fe8a48ffe79440a7ed3de71da92fbe42212ce08e0211de5aac5a1"
  description = "Полный путь к образу с тегом или digest"
}

variable "container_port" {
  type        = number
  default     = 8080
  description = "Порт, который слушает приложение"
}

variable "ghcr_username" {
  type        = string
  default     = "hamka-123"
  description = "Имя пользователя GitHub"
}

variable "ghcr_pat_token" {
  type        = string
  sensitive   = true
  description = "GitHub Personal Access Token (PAT) с правами read:packages"
}
