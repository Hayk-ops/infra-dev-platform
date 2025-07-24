variable "name" {
  description = "ACR name"
  type        = string
}

variable "sku" {
  type = string
}

variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
}

variable "github_oidc_object_id" {
  description = "We have to get it to give respective permissions to certain user for further interaction"
  type        = string
}