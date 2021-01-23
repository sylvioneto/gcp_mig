
project_id = "spedroza-test-multiregion"
dns_name   = "sandbox.sneto.ca"
vpc        = "demo-multi-region"
mig_name   = "demo-multi-region"

resource_labels = {
  terraform   = "true"
  cost-center = "training"
  env         = "sandbox"
}

subnet_list = [
  {
    name   = "usa"
    region = "us-east1",
    cidr   = "10.0.1.0/24",
  },
  {
    name   = "canada"
    region = "northamerica-northeast1",
    cidr   = "10.0.2.0/24",
  },
]

# install nginx to test our load balancer
startup_script = <<EOT
  #!/bin/bash
  curl -sSO https://dl.google.com/cloudagents/install-monitoring-agent.sh
  sudo bash install-monitoring-agent.sh
  curl -sSO https://dl.google.com/cloudagents/install-logging-agent.sh
  sudo bash install-logging-agent.sh
  sudo apt-get -yq update
  sudo apt-get -yq install nginx
  EOT
