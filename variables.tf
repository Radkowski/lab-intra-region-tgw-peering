data "aws_caller_identity" "current" {}
data "aws_region" "current" {}



# main module

variable "DeploymentRegion" {
  default = "DATA TO BE PROVIDED"
  type    = string
}

variable "HubTGWID" {
  default = "DATA TO BE PROVIDED"
  type    = string
}

variable "HubTGWRouteTable" {
  default = "DATA TO BE PROVIDED"
  type    = string
}

variable "HubAccountID" {
  default = "DATA TO BE PROVIDED"
  type    = string
}

variable "SpokeAccountID" {
  default = "DATA TO BE PROVIDED"
  type    = string
}

variable "SpokeCIDR" {
  default = "DATA TO BE PROVIDED"
  type    = string
}
