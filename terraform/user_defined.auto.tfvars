
project_id               = "spedroza-test-multiregion"
dns_name                 = "sandbox.sneto.ca"
vpc                      = "demo-multi-region"

resource_labels = {
  terraform   = "true"
  cost-center = "training"
  env         = "sandbox"
}

subnet_list = [
  {
    name     = "usa"
    region   = "us-east1",
    cidr     = "10.0.1.0/24",
  },
  {
    name     = "canada"
    region   = "northamerica-northeast1",
    cidr     = "10.0.2.0/24",
  },
]