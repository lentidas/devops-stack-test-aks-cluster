# devops-stack-test-aks-cluster

Repository that holds the Terraform files for my test cluster on Microsoft AKS using Camptocamp's [DevOps Stack](https://devops-stack.io/).

```bash
# Create the cluster
summon terraform init && summon terraform apply

# Get the kubeconfig settings for the created cluster

# Destroy the cluster
summon terraform state rm $(summon terraform state list | grep "argocd_application\|argocd_project\|argocd_cluster\|argocd_repository\|kubernetes_\|helm_") && summon terraform destroy
```
