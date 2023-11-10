variable "region" {
  default = "West Europe"
}

variable "tenant_id" {
  default = "ce4775d3-1c2e-4644-b2bc-631c157d2be7"
}

variable "subscription_id" {
  default = "77bb0b07-57e5-44b5-a350-310a93917298"
}

variable "client_id" {
  default = "88b89f8b-ffc6-4d7a-8d6e-1e59338c6844"
}

variable "default_password" {
  sensitive = true
  type      = string
}