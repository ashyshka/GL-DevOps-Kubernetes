# POC for AsciiArtify
## This is will contain step by step manual
- install kubernetes cluster (we will using k3s/k3d)
- install and initial setup ArgoCD as CI/CD tool

**Attention: This is wery short manual, only for initial setup, more detailed we will have at the MVP stage**

### Why ArgoCD ?
Shortly - ArgoCD realize  concept, where we have Git Repository as a Source of Truth, so - any changes in the repository will affect our applivation in the cluster.
This is realize GitOps concept and allow us keep our app ith the cluster up up date, based by repository status.
This is all what we need.

### Install Kubernetes Cluster, using k3d/k3s
Note: This step shown at the demo in the Concept stage, but here we will have easy instruction to reproducing it (we mean, we using linux)

	# Creating cluster
	k3d cluster create demo
    # Just checking if cluster ready to use
    > k3d cluster list
		NAME   SERVERS   AGENTS   LOADBALANCER
		demo   1/1       0/0      true
    > kubectl cluster-info 
		Kubernetes control plane is running at https://0.0.0.0:15023
		CoreDNS is running at https://0.0.0.0:15023/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
		Metrics-server is running at https://0.0.0.0:15023/api/v1/namespaces/kube-system/services/https:metrics-server:https/proxy
    # Looking which nodes we are have
    > kubectl get no
		NAME                STATUS   ROLES                  AGE   VERSION
		k3d-demo-server-0   Ready    control-plane,master   30h   v1.27.4+k3s1
    # Looking which namespaces we are have
    > kubectl get ns
		NAME              STATUS   AGE
		default           Active   31h
		kube-system       Active   31h
		kube-public       Active   31h
		kube-node-lease   Active   31h
    # Looking which resources we have in the all namespaces
	> kubectl get all -A
		NAMESPACE     NAME                                         READY   STATUS      RESTARTS   AGE
		kube-system   pod/local-path-provisioner-957fdf8bc-cn94c   1/1     Running     0          32h
		kube-system   pod/coredns-77ccd57875-2hqnc                 1/1     Running     0          32h
		kube-system   pod/helm-install-traefik-crd-8cqnk           0/1     Completed   0          32h
		kube-system   pod/helm-install-traefik-8gdgk               0/1     Completed   1          32h
		kube-system   pod/svclb-traefik-a6f6c3ed-26782             2/2     Running     0          32h
		kube-system   pod/metrics-server-648b5df564-shnsp          1/1     Running     0          32h
		kube-system   pod/traefik-64f55bb67d-gxzdb                 1/1     Running     0          32h

		NAMESPACE     NAME                     TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)                      AGE
		default       service/kubernetes       ClusterIP      10.43.0.1       <none>        443/TCP                      32h
		kube-system   service/kube-dns         ClusterIP      10.43.0.10      <none>        53/UDP,53/TCP,9153/TCP       32h
		kube-system   service/metrics-server   ClusterIP      10.43.236.146   <none>        443/TCP                      32h
		kube-system   service/traefik          LoadBalancer   10.43.66.240    172.18.0.2    80:30124/TCP,443:32345/TCP   32h

		NAMESPACE     NAME                                    DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
		kube-system   daemonset.apps/svclb-traefik-a6f6c3ed   1         1         1       1            1           <none>          32h

		NAMESPACE     NAME                                     READY   UP-TO-DATE   AVAILABLE   AGE
		kube-system   deployment.apps/local-path-provisioner   1/1     1            1           32h
		kube-system   deployment.apps/coredns                  1/1     1            1           32h
		kube-system   deployment.apps/metrics-server           1/1     1            1           32h
		kube-system   deployment.apps/traefik                  1/1     1            1           32h

		NAMESPACE     NAME                                               DESIRED   CURRENT   READY   AGE
		kube-system   replicaset.apps/local-path-provisioner-957fdf8bc   1         1         1       32h
		kube-system   replicaset.apps/coredns-77ccd57875                 1         1         1       32h
		kube-system   replicaset.apps/metrics-server-648b5df564          1         1         1       32h
		kube-system   replicaset.apps/traefik-64f55bb67d                 1         1         1       32h

		NAMESPACE     NAME                                 COMPLETIONS   DURATION   AGE
		kube-system   job.batch/helm-install-traefik-crd   1/1           31s        32h
		kube-system   job.batch/helm-install-traefik       1/1           33s        32h

**So here we have cluster, ready to instal an setup ArcoCD**


### Install and initial setup ArgoCD as CI/CD tool
Note: We can using Helm Charts to install ArgoCD, but now we will use simle method with apply manifest yaml file

** Step One - Deploying ArgoCd to our cluster**


	# Creating dedicated NS (namespace) for ArgoCD
	> kubectl create namespace argocd
		namespace/argocd created
	# Deploying ArgoCD to the this NS
	> kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
		customresourcedefinition.apiextensions.k8s.io/applications.argoproj.io created
		customresourcedefinition.apiextensions.k8s.io/applicationsets.argoproj.io created
        ...
        networkpolicy.networking.k8s.io/argocd-repo-server-network-policy created
		networkpolicy.networking.k8s.io/argocd-server-network-policy created

	# This step not mandatory - just if we need check if ArgoCD pods up and running
    > kubectl get po -n argocd
		NAME                                               READY   STATUS    RESTARTS   AGE
		argocd-redis-b5d6bf5f5-hkw6l                       1/1     Running   0          115s
		argocd-notifications-controller-db4f975f8-j8ms6    1/1     Running   0          115s
		argocd-applicationset-controller-dc5c4c965-k7llr   1/1     Running   0          115s
		argocd-server-557c4c6dff-wddxh                     1/1     Running   0          115s
		argocd-application-controller-0                    1/1     Running   0          115s
		argocd-dex-server-9769d6499-ns4gv                  1/1     Running   0          115s
		argocd-repo-server-579cdc7849-ng9k8                1/1     Running   0          115s

** So, we cat see - ArgoCD deployed and all pods up and running**

**Step Two - Lets get access to the ArgoCD WEB GUI**

Note: ArgoCD WEB GUI listen on port 443 (HTTPS), initial user with admin rights is `admin` and password is autogenerated

We can get admin password in two way
- look inside secret and show it
- install argoCD CLI and and change password to any which we want

We will try first way.


	# All secrets storing in BASE64, so, we need to decode it
    > kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
		2KEgCE6ZXvY6mwL2
	# Now we have autogenerated password - 2KEgCE6ZXvY6mwL2

Now, just doing port-forward from our Linux Host to argoCD service

	kubectl port-forward svc/argocd-server -n argocd 8080:443

When we will try to connect to API Server in browser with https://localhost:8080 we will ger error `Warning: Potential Security Risk Ahead` - just need to `accept The Risk and Continue`
Right now - just fill fields `Username` and `Password` with `admin` and `2KEgCE6ZXvY6mwL2` and do `SIGN IN`

![Thats all - we have access to ArgoCD WEB GUI.](https://github.com/ashyshka/AsciiArtify/blob/main/doc/POC_ArgoCD.png)
