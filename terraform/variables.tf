locals {
  _labels = {
    project   = "demo-multi-region",
  }
  resource_labels = merge(local._labels, var.resource_labels)
}

variable "project_id" {
  description = "Google Project ID"
}

variable "region" {
  description = "Region used by default in all regional resources. https://cloud.google.com/compute/docs/regions-zones"
  default     = "us-central1"
}

variable "dns_name" {
  description = "Public DNS name, e.g sandbox.mydomain.com"
}

variable "vpc" {
  type        = string
  description = "VPC name or self-link"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  default     = "10.0.0.0/8"
}

variable "subnet_list" {
  type        = list(map(any))
  description = "Subnet config list. Please look at the readme.md for examples."
  default = []
}

variable "machine_type" {
  type        = string
  description = "GCP machine type"
  default     = "g1-small"
}

variable "preemptible" {
  type        = bool
  description = "Preemptible VMs"
  default     = true
}

variable "resource_labels" {
  description = "Resource labels"
  default     = {}
}

variable "tags" {
  description = "Network tags"
  default     = []
}
