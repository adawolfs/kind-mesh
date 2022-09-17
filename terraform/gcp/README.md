
# Google Cloud Platform

Google Cloud Platform (GCP) is a suite of cloud computing services that runs on the same infrastructure that Google uses internally for its end-user products, such as Google Search, Gmail, file storage, and YouTube.

## Prerequisites
Install Google Cloud SDK
```bash
sudo apt-get install -y curl unzip
curl -sSL https://sdk.cloud.google.com | bash
exec -l $SHELL
gcloud init
```
## Create project
```bash
export PROJECT_ID="kind-mesh"
gcloud projects create $PROJECT_ID
gcloud config set project $PROJECT_ID
```

## Enable Billing
https://cloud.google.com/billing/docs/how-to/modify-project#enable_billing_for_a_project

## List services
```bash
gcloud services list
```

## Enable services
```bash
gcloud services enable compute.googleapis.com
gcloud services enable cloudresourcemanager.googleapis.com
```

## Create Service account
```bash
export SA_NAME="terraform-kind-mesh"
gcloud iam service-accounts create $SA_NAME \
    --description="Terraform Kind Mesh" \
    --display-name="Terraform Kind Mesh"
```

## Add account to IAM
```bash
gcloud iam service-accounts add-iam-policy-binding \
    $SA_NAME@$PROJECT_ID.iam.gserviceaccount.com \
    --member="user:$(gcloud config get-value account)" \
    --role="roles/iam.serviceAccountUser"
```

## Create credentials file
```bash
gcloud iam service-accounts keys create \
    credentials.json \
    --iam-account=$SA_NAME@$PROJECT_ID.iam.gserviceaccount.com 
```

## IAM Policies
```bash
gcloud projects get-iam-policy $PROJECT_ID \
    --flatten="bindings[].members" \
    --format='table(bindings.role)' \
    --filter="bindings.members:$SA_NAME@$PROJECT_ID.iam.gserviceaccount.com"
```

## Add IAM Policy
```bash
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:$SA_NAME@$PROJECT_ID.iam.gserviceaccount.com" \
    --role="roles/compute.admin"
```

## Create infrastructure with Terraform
```bash
terraform init
terraform plan
terraform apply
```
## List Compute Instances
```bash
gcloud compute instances list
```

## SSH into Compute Instance
```bash
export COMPUTE_INSTANCE="server"
export PROJECT_ZONE="us-east1-b"
ssh -i ssh-key sa_$(gcloud iam service-accounts describe \
    $SA_NAME@$(gcloud config get-value project).iam.gserviceaccount.com \
    --format='value(oauth2ClientId)')@$(gcloud compute instances describe $COMPUTE_INSTANCE \
    --zone $PROJECT_ZONE \
    --format='value(networkInterfaces[0].accessConfigs[0].natIP)')
```