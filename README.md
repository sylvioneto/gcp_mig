# GCP - Managed Instance Groups with Global Load Balancer

This project demonstrates how to deploy a Global Load Balancer with two regional Managed Instance Groups as backends.

It deploys two Managed Instance Groups running NGINX. The USA group is located in us-east1, and the CANADA group in northamerica-northeast1.

After deploying it, you can hit the Load Balancer IP from different regions using VMs, and see how GCP is spliting the traffic, for example:
![traffic_metrics](images/traffic-metrics.png)

## Deploy

### Preparation (only first time)
```
# TF State bucket creation
gsutil mb gs://<YOUR PROJECT NAME>-tf-state

# Set permissions
export PROJECT_ID=<YOUR PROJECT ID>
PROJECT_NUMBER=$(gcloud projects describe $PROJECT_ID --format='value(projectNumber)')
MEMBER=serviceAccount:$PROJECT_NUMBER@cloudbuild.gserviceaccount.com
gcloud projects add-iam-policy-binding $PROJECT_ID --member=$MEMBER --role=roles/editor

MEMBER=serviceAccount:$PROJECT_NUMBER-compute@developer.gserviceaccount.com
gcloud projects add-iam-policy-binding $PROJECT_ID --member=$MEMBER --role=roles/editor

# Enable APIs
gcloud services enable compute.googleapis.com \
    cloudresourcemanager.googleapis.com \
    iam.googleapis.com \
    logging.googleapis.com \
    --project $PROJECT_ID
```

### Deploy
```
gcloud builds submit . --config build/cloudbuild.yaml
```

### Destroy
```
gcloud builds submit . --config build/cloudbuild_destroy.yaml
```
