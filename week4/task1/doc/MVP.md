# MVP for AsciiArtify
## We mean what AsciiAffinity dev team start in MVP stage. Our tasks will be create ArgoCD App to make changes in the cluster when any changes in the git repo was did.

## This document will contain all commands for all steps and short demo what we need to do.

We will show it based at the git repo, forked from https://github.com/den-vasyliev/go-demo-app to https://github.com/ashyshka/go-demo-app(and just renamed branch `master` to `main`)
We will show ArgoCD actions with changing some file (./helm/values.yaml) to look how ArgoCD will react to the changing and make changing for cluster.
This is will two options - manual sync, and automatic sync.

### Plan to checking it.
1. For first - add ArgoCD app for us (with manual sync mode) and sync our app.
2. Check how it works:
	-  We will changing API Gateway Service type to the LoadBalancer (this is wrong value), syncing our app and will see how ArgoCD will react to changes.
	- We will troubleshooting what affect to our app can't sync property (thi is will be Gateway Service type)
	- We will changing API Gateway Service type to the NodePort (this is correct value), syncing our app and will see how ArgoCD will react to changes.
5. Will switching our ArgoCD app to automatic sync mode and will doing same for this.


### Commands that were used
##### Just checking if our app conponent ( ambassador in this case) is UP
	kubectl port-forward -n demo svc/ambassador 8088:80
	curl localhost:8088

#### Just checking if our app component ( ambassador in this case ) is WORKING PROPERLY
	wget -O /tmp/g.png https://www.google.com/images/branding/1x/googlelogo_color_272x92dp.png
	curl -F 'image=@/tmp/g.png' localhost:8088/img/


**Add App to ArgoCD**
![Add App to ArgoCD](https://github.com/ashyshka/AsciiArtify/blob/main/doc/MVP_Add_App.gif)
**Acton ArgoCD App with Manual Sync with changing some fille in repo**
![Acton ArgoCD App with Manual Sync with changing some fille in repo](https://github.com/ashyshka/AsciiArtify/blob/main/doc/MVP_Manual_Sync.gif)
**Acton ArgoCD App with Automatic Sync with changing some fille in repo**
![Acton ArgoCD App with Automatic Sync with changing some fille in repo](https://github.com/ashyshka/AsciiArtify/blob/main/doc/MVP_Auto_Sync.gif)

Known Issues: Sometimes, after changing `API Gateway Service type` to correct value and `Sync` - we can see react ArgoCD immediately, but this is looks like Out Of Sync. Thats Ok - just to click on the  `Refresh` button.
