## Preduslovi

Potrebno je da budu instalirani:

```bash
git --version
terraform version
infracost --version
kubectl version --client
minikube version
helm version
```

## Terraform komande

Ulazak u Terraform folder:

```bash
cd terraform
```

Inicijalizacija Terraform projekta:

```bash
terraform init
```

Formatiranje Terraform fajlova:

```bash
terraform fmt
```

Validacija Terraform konfiguracije:

```bash
terraform validate
```

Terraform plan, ako su podešeni cloud kredencijali:

```bash
terraform plan
```

Povratak u root folder projekta:

```bash
cd ..
```

## Infracost lokalna provera

Osnovno podešavanje Infracost CLI alata:

```bash
infracost setup
```

Lokalna analiza Terraform koda iz root foldera projekta:

```bash
infracost scan --path terraform
```

Ako se komanda pokreće iz `terraform` foldera:

```bash
infracost scan
```

## Infracost CI setup

Povezivanje repozitorijuma sa Infracost CI integracijom:

```bash
infracost ci setup --ci-pipeline
```

Nakon setup-a dodati generisane workflow fajlove u Git:

```bash
git add .github/workflows/infracost-diff.yml .github/workflows/infracost-scan.yml
git commit -m "chore: add Infracost CI integration"
git push
```

Infracost token se ne upisuje u kod. Čuva se kao GitHub Repository Secret:

```text
INFRACOST_API_KEY
```

Ako je Terraform kod u folderu `terraform`, proveriti da `infracost-scan.yml` koristi:

```yaml
path: terraform
```

## Test Pull Request scenarija

Prelazak na glavnu granu:

```bash
git checkout main
git pull origin main
```

Kreiranje test grane:

```bash
git checkout -b increase-ec2-capacity
```

Nakon izmene Terraform fajlova:

```bash
cd terraform
terraform fmt
terraform validate
cd ..
```

Commit i push izmene:

```bash
git add terraform/
git commit -m "Increase EC2 instance capacity"
git push -u origin increase-ec2-capacity
```

Zatim se na GitHub-u otvara Pull Request iz grane:

```text
increase-ec2-capacity -> main
```

## Pokretanje Minikube klastera

Pokretanje lokalnog Kubernetes klastera:

```bash
minikube start
```

Provera statusa:

```bash
minikube status
```

Provera node-ova:

```bash
kubectl get nodes
```

Provera namespace-ova:

```bash
kubectl get namespaces
```

Provera svih podova:

```bash
kubectl get pods -A
```

## Instalacija OpenCost-a

Dodavanje OpenCost Helm repozitorijuma:

```bash
helm repo add opencost https://opencost.github.io/opencost-helm-chart
helm repo update
```

Instalacija OpenCost-a:

```bash
helm install opencost opencost/opencost \
  --namespace opencost \
  --create-namespace
```

Provera namespace-a:

```bash
kubectl get namespaces
```

Provera OpenCost podova:

```bash
kubectl get pods -n opencost
```

Provera OpenCost servisa:

```bash
kubectl get services -n opencost
```

Port-forward za OpenCost:

```bash
kubectl port-forward --namespace opencost service/opencost 9003:9003 9090:9090
```

OpenCost dashboard:

```text
http://localhost:9090
```

OpenCost API provera:

```text
http://localhost:9003/allocation/compute?window=60m
```

## Pokretanje test Kubernetes aplikacija

Primena svih Kubernetes manifest fajlova:

```bash
kubectl apply -f k8s/
```

Provera deployment-a:

```bash
kubectl get deployments -n finops-demo
```

Provera podova:

```bash
kubectl get pods -n finops-demo
```

Detalji deployment-a:

```bash
kubectl describe deployment low-cost-app -n finops-demo
kubectl describe deployment medium-cost-app -n finops-demo
kubectl describe deployment high-cost-app -n finops-demo
```

## Čišćenje Kubernetes resursa

Brisanje test aplikacija:

```bash
kubectl delete -f k8s/
```

Brisanje OpenCost instalacije:

```bash
helm uninstall opencost -n opencost
kubectl delete namespace opencost
```

Zaustavljanje Minikube klastera:

```bash
minikube stop
```

Brisanje Minikube klastera, ako je potrebno:

```bash
minikube delete
```

## Git komande

Provera statusa:

```bash
git status
```

Dodavanje izmena:

```bash
git add .
```

Commit:

```bash
git commit -m "Update project files"
```

Push:

```bash
git push
```
