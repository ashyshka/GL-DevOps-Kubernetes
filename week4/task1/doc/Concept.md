# Deployment Tools Proposition for AsciiArtify

# Introduction
For local development and  deployment and ready to use in the Kubernetes in the future, we have, i think several k8s (kubernetes alternatives).
In this document we lill look at the all of them. Also, we will usind Podman instead Docker for build containers.
The following aspects are considered relevant for software development use cases:

- Easy of installation
- Easy of use, complexity
- Feature completeness (especially for development and production parity)
- Resource consumption
- Overall usability (the so-called developer experience, DX)

# Characteristics

## KinD (It means Kubernetes-IN-Docker. )

KinD is Kubernetes SIGs project<br>Github stars: ~11.7k<br>Contributors: 200+<br>First commit: Sep 2018<br>Main developer: Kubernetes SIG


	Supported OS and Architectures: MacOS and Windows at the AMD64, Linux at the AMD64/ARM64
    Automation Posssibility: Support easy create cluster, can`t use addons 
    Additional Features: Have'nt any monitoring and logging system, but can use kubectl and in-box CLI for managing cluster

## minikube

Minikube is another Kubernetes SIGs project.<br>Github stars: ~26.8k<br>Contributors: 650+<br>First commit: Apr 2016<br>Main developer: Kubernetes SIG

	Supported OS and Architectures: MacOS, Windows and Linux at the very wide set of achritectures
    Automation Posssibility: Support easy create cluster, can use addons 
    Additional Features: Have Kuberneted Dashboard from the box, can use kubectl and WEB UI (dashboard)for managing cluster. Most popular local k8s alternative

## k3s/k3d

Github stars: ~23.4k<br>Contributors: 1750+ (?)<br>First commit: Jan 2019<br>Main developer: Rancher

	Supported OS and Architectures: MacOS, Linux and Windows (need to use WSL2) at the very wide set of achritectures
    Automation Posssibility: Support easy create cluster, can`t use addons, but can using some plugins
    Additional Features: Have`nt monitoring sysyem from the box. but we have k3x - graphics interface (for Linux) to k3d, can use kubectl amd WEB UI (k3d)for managing cluster. Rancher develops very fast with many options.

## Podman
Daemon less tool for managing docker containers

	Supported OS and Architectures: MacOS, Linux and Windows (need to use WSL2 for Buildah utility) at the AMD64/ARM64 with OS depends.
    Automation Posssibility: Can`t create cluster, but can to do it with Podman Desktop and KinD
    Additional Features: Similar to KinD

## Comparison Table

| Feature | KinD | Minikube | K3S/K3D |
| ----------- | ----------- | ----------- | ----------- |
| CNCF Cert | + | + | + |
| Single Node Cluster | + | + | + |
| Multi Node Cluster | + | + | + |
| Architecture Support | AMD64, ARM64 | AMD64, ARM64, etc | AMD64, ARM64, etc |
| OS Support | MacOS, Windows and Linux | MacOS, Windows and Linux | MacOS, Windows and Linux |
| Min CPU Req. | 1+ | 2+ | 1+ |
| Min RAM Req. | minimum | 2GB | 512M |
| Container Runtime| Docker, CRI-O | Docker, CRI-O, comtainerd | Docker, containerd |
| Networking (CNI) | kindnet | Calico, Cilium, Flannel | Flannel (other with plugins) |
| startup time initial/following | 2:48 / 1:06 | 5:19 / 3:15 | 0:15 / 0:15 |
| Mount Host FS to container | HostPath + docker mount | HostPath + ( OS depend) ) | HostPath + docker mount |
| Intallatoion | Easy | Easy | Easy |
| Usability | Easy | Medium complexity | Easiest |


## Pros/Cons Table

All cases can be used for local development and testing,will loook only to main differences

|  | KinD | Minikube | K3S/K3D |
| ----------- | ----------- | ----------- | ----------- |
| Pros | Very Minimal HW Req.<br>Easy to installation and use<br>Can be used for local developmen/testing | Most popular local kubernetes, have a big community<br>Have addons to extend functionality<br>Easy to installation<br>Can be used for local developmen/testing | Very fast starup<br>Easy to installation, have less CLI command then minikube but very close in capabilities<br>Easiest to use<br>Can be used for local developmen/testing |
| Cons | Have minimal possibility to scaling<br>Can`t use remote images, need to pull to node with docker or podman<br>and this is potential problem to use at the multiple nodes | Most Resource consumption,  this is can be a problem<br>Can`t create several clusters<br>Usability more complexity than competitors  | Started at the 2019, have less community than competitors<br>Not so clear how to scale in the offiicial documentation, but we can this found at the SUSE documentation (Rancher by SUSE)  |

## Conclusion

I tried all cases a i sure - k3d will be better, especially for develoypmen and startups. All cases have advantages and disadvantages, but k3s look more faster, more easy to use, and maybe, have less CLI command then minicube, but very close to this with features. And this looks very close to use in production with low loads. I will recommend AsciiArtify to use this product.

All products have minimal differents in use, so i will keep here demo with this one
All steps to reproduce it you can found in file https://github.com/ashyshka/GL-DevOps-Kubernetes/blob/main/week4/task1/prepared-lines-just-for-copy-paste.txt


![DEMO](https://github.com/ashyshka/AsciiArtify/blob/main/doc/k3d_demo.gif)
