# We will do that with few easy steps

#### For first we will fork all needed repo into several own - this is for more comfortable working, ofcourse (if we need make some changes in the future)

- https://github.com/ashyshka/tf-fluxcd-flux-bootstrap
- https://github.com/ashyshka/tf-github-repository
- https://github.com/ashyshka/tf-hashicorp-tls-keys
- https://github.com/ashyshka/tf-kind-cluster


**Need to inspect some repo and look which changes we will need - need to know which vars we can use, for example**
- https://github.com/ashyshka/tf-kind-cluster/blob/cert_auth/output.tf

**And next steps - we need to modify some files in our terraform conf to use flux
need to add modules and new variables, which we will use (we will use not local modules, fron github)
and for now, we will use local kind k8s cluster instead GKE**

```
./main.tf
./variables.tf
```
**NOTE:** we will use our own module, so we need to add it to `main.tf` file too (look it in the folder `./modules/flux-gitops-demo`)

**Now, we can install local flux cli, just fo comrortable and looking logs**
`> curl -s https://fluxcd.io/install.sh | bash`

**For this time, we need to preparing some files to make flux could interact with our cluster when we will make some changes in our repo**

We will do that

- just create directory `./modules/flux-gitops-demo/manifests` if it not exists yet
- create/modify file `./modules/flux-gitops-demo/manifests/ns.yaml` with this content
```
---
apiVersion: v1
kind: Namespace
metadata:
  name: demo
```
- do this
```
  flux create source git kbot \
    --url=https://github.com/ashyshka/kbot \
    --branch=develop \
    --namespace=demo \
    --export > ./modules/flux-gitops-demo/manifests/kbot-gr.yaml
```
- do this
```
  flux create helmrelease kbot \
    --namespace=demo \
    --source=GitRepository/kbot \
    --chart="./helm" \
    --interval=1m \
    --export > ./modules/flux-gitops-demo/manifests/kbot-hr.yaml
```
- change in last file `apiVersion: helm.toolkit.fluxcd.io/v2beta2 -> apiVersion: helm.toolkit.fluxcd.io/v2beta1`


**Now, we can start working with it, it`s easy, steb by step**
```
> terraform init
> terraform validate
and if all ok
> export TF_VAR_GITHUB_OWNER=something
> export TF_VAR_GITHUB_TOKEN=something
> terraform plan
> terraform apply
```

**Terraform will creating kind cluster and all resourcer, which needed for us. 
We can check this and can look something like this**

```
> terraform state list
module.flux_bootstrap.flux_bootstrap_git.this
module.github_repository.github_repository.this
module.github_repository.github_repository_deploy_key.this
module.kind_cluster.kind_cluster.this
module.tls_private_key.tls_private_key.this
```

**So, now we have kind cluster with installed flux**
Flux will create repo, where it will store all manifests for using
- https://github.com/ashyshka/flux-gitops

This is files, which have definitions to creating some kinds to use with Flux, they are can be foun here 
- https://github.com/ashyshka/GL-DevOps-Kubernetes/tree/main/week7/task3/flux-gitops-demo

- Flux will follow to the changes at the repository https://github.com/ashyshka/kbot
- for changes in file https://raw.githubusercontent.com/ashyshka/kbot/develop/helm/Chart.yaml

for field `version:`

All changes in the file `Chart.yaml` makes with GitHub Actions
- https://raw.githubusercontent.com/ashyshka/kbot/develop/.github/workflows/cicd.yaml

And after it, Flux will deploy new version into our cluster

**This is just example repo, working repo can be seeng here (just stil work at the next tasks here, so - that repo can be changed)**
- https://github.com/ashyshka/tf_gke
