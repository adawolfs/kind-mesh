
# Google Cloud Platform
## Create Service account
```
gcloud iam service-accounts create terraform-kind-mesh \
    --description="Terraform Kind Mesh" \
    --display-name="Terraform Kind Mesh"
```

## Add account to IAM
```
gcloud iam service-accounts add-iam-policy-binding \
    terraform-kind-mesh@kind-mesh.iam.gserviceaccount.com \
    --member="user:$(gcloud config get-value account)" \
    --role="roles/iam.serviceAccountUser"
```

## Create credentials file
```
gcloud iam service-accounts keys create \
    credentials.json \
    --iam-account=terraform-kind-mesh@kind-mesh.iam.gserviceaccount.com
```


## IAM Plicies
```
gcloud projects get-iam-policy kind-mesh
```

## 
```
gcloud projects add-iam-policy-binding kind-mesh \
    --member="serviceAccount:terraform-kind-mesh@kind-mesh.iam.gserviceaccount.com" \
    --role="roles/compute.admin"
```