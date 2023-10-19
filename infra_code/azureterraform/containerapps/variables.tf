variable "resource" {
  description = "Resource Group Name"
  default     = "devopstest"
}
variable "location" {
  description = "Location Name"
  default     = "eastus"
}
variable "cr" {
  description = "Container Registry"
  default     = "10dapps"
}
variable "log" {
  description = "Log Analytics Workspace"
  default     = "acctest-01"
}
variable "env" {
  description = "Container app env"
  default     = "example-env"
}
variable "containerapp" {
  description = "Contianer App Name"
  default     = "sampleapp"
}
variable "vnet" {
  description = "Virtual Network Name"
  default     = "myvnet"
}
variable "subnet" {
  description = "Subnet Name"
  default     = "mysubnet"
}
variable "publicip" {
  description = "Public Ip"
  default = "mypublicip"
}
variable "applicationgateway" {
  description = "Application Gateway Name"
  default = "myappgwy"
}
variable "registry" {
  default = "<REGISTRY>"
}
variable "registry_name"{
  default = "<REGISTRY_NAME>"
}
variable "registry_password" {
  default = "<REGISTRY_PASSWORD>"
}