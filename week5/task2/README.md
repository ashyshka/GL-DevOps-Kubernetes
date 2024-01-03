# ATTENTION: I HAD A MY STATUS PAGE LOST AFTER SETUP BY MISTAKE :(
# THIS IS CORRECT STATUS PAGE https://stats.uptimerobot.com/q2vzZCL9LX


#### Task 2.1
**gcloud login and set CredHelpers in the docker config.json for gcloud artifact registry**
```
gcloud auth login
gcloud auth configure-docker europe-central2-docker.pkg.dev

#### Task 1
```
**create GKE cluster and ensure if context is correct**
```
gcloud beta interactive
gcloud container clusters create demo --zone europe-central2-a --machine-type e2-medium --num-nodes 2
kubectl config get-contexts
```
**build and push v1.0.0 our demo app**
```
docker build -t europe-central2-docker.pkg.dev/gl-devops-and-kubernetes/k3s-k3d/demo:1.0.0 .
docker push europe-central2-docker.pkg.dev/gl-devops-and-kubernetes/k3s-k3d/demo:1.0.0
```
**preparind and deploy v1.0.0 our demo app**
```
kubectl create namespace demo
kubectl config set-context --current --namespace demo
kubectl create deployment demo-v1 --image europe-central2-docker.pkg.dev/gl-devops-and-kubernetes/k3s-k3d/demo:1.0.0
kubectl expose deployment demo-v1 --port 80 --type LoadBalancer --target-port 8080
```
**waiting to IP will be assigned, set env var to LoadBalancer IP**
```
kubectl get svc -w
LB=$(kubectl get svc demo-v1 -o jsonpath="{..ingress[0].ip}")
```
**how to do continuous check**
```
while true; do curl $LB ; sleep 0.3 ; done
```
#### Set up Uptime Robot Monitorings to the this IP with Keywords "Version: 1.0.0" and add to Public Status Page
#### Task 2.2
**build and push v2.0.0, create deploymment**
```
sed -i 's/1.0.0/2.0.0/g' Dockerfile
docker build -t europe-central2-docker.pkg.dev/gl-devops-and-kubernetes/k3s-k3d/demo:2.0.0 .
docker push europe-central2-docker.pkg.dev/gl-devops-and-kubernetes/k3s-k3d/demo:2.0.0
kubectl create deployment demo-v2 --image europe-central2-docker.pkg.dev/gl-devops-and-kubernetes/k3s-k3d/demo:2.0.0
```
**set annotation to all demo deployment**
```
kubectl annotate deploy demo-v1 kubernetes.io/change-cause="v1.0.0"
kubectl annotate deploy demo-v2 kubernetes.io/change-cause="v2.0.0"
```
**try Blue-Green Deployment - Just switch between images (releases) - waitimg between switches to collect statistics**
kubectl set image deploy demo-v1 demo=europe-central2-docker.pkg.dev/gl-devops-and-kubernetes/k3s-k3d/demo:2.0.0
kubectl set image deploy demo-v1 demo=europe-central2-docker.pkg.dev/gl-devops-and-kubernetes/k3s-k3d/demo:1.0.0
**manual change label on the fly**
```
kubectl label po --all run=demo
kubectl edit svc demo-v1 # change selector -> run: demo
```
**try Canary Deployment - scaling pods**
```
kubectl scale deployment demo-v1 --replicas 3
kubectl scale deployment demo-v2 --replicas 9
```
#### wait a bit - just check reaction and do labels scaled pods
kubectl label po --all run=demo
**left only v2.0.0 demo app**
kubectl scale deployment demo-v1 --replicas 0
kubectl scale deployment demo-v2 --replicas 1
#### Set up Uptime Robot Monitorings to the this IP with Keywords "Version: 2.0.0" and add to Public Status Page
#### wait a bit - just check reaction and wait to collect statistics for Uptime Robot
**remove cluster**  
```
gcloud container clusters delete demo --zone europe-central2-a
```

