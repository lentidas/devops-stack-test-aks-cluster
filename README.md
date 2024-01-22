# devops-stack-test-aks-cluster

Repository that holds the Terraform files for my test cluster on Microsoft AKS using Camptocamp's [DevOps Stack](https://devops-stack.io/).

```bash
# Login to the Azure account
az login

# Check that your are in the proper subscription
az account set --subscription 118c1218-c90c-4c5c-bf1c-b51802b9a986

# Create the cluster
summon terraform init && summon terraform apply

# Get the kubeconfig settings for the created cluster
az aks get-credentials --resource-group gh-aks-cluster-rg --name gh-aks-cluster --file ~/.kube/is-sandbox-azure-gh-aks-cluster.config

# Destroy the cluster
terraform state rm $(terraform state list | grep "argocd_application\|argocd_project\|argocd_repository\|argocd_cluster\|kubernetes_\|helm_\|keycloak_") && terraform destroy
```
