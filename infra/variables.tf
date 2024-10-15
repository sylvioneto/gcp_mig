variable "project_id" {
  description = "Project ID"
}

variable "region" {
  description = "Main region used by default in all regional resources. https://cloud.google.com/compute/docs/regions-zones"
  default     = "us-central1"
}

variable "vpc" {
  type        = string
  description = "VPC name or self-link"
  default     = "vpc-test"
}

variable "subnet_list" {
  type        = list(map(any))
  description = "Subnet config list. Please look at the readme.md for examples."
  default = [
    {
      name   = "usa"
      region = "us-east1",
      cidr   = "10.0.1.0/24",
    },
    {
      name   = "brazil"
      region = "southamerica-east1",
      cidr   = "10.0.2.0/24",
    },
  ]

}

variable "resource_labels" {
  description = "Resource labels"
  default = {
    terraform   = "true"
    cost-center = "training"
    env         = "sandbox"
  }
}

variable "mig_name" {
  type    = string
  default = "nginx"
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

variable "startup_script" {
  description = "Startup script. By default it installs Cloud Logging and Cloud Monitoring agents"
  default     = <<EOT
  #!/bin/bash
  sudo apt-get -y update
  sudo apt-get -y install nginx
  EOT
}

variable "image" {
  description = "OS Image"
  default     = "debian-cloud/debian-11"
}
