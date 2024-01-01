### Manual to use k8s plugin for kubectl top with explain were was errors before

So, right now this script looks like a trivial bash script, but this one have error.

```
RESOURCE_TYPE=$0
```
** This is wrong usage: `$0` using for the show name of the script being executed* **
```
# Retrieve resource usage statistics from Kubernetes
kubectl $2 $RESOURCE_TYPE -n $1 | tail -n +2 | while read line
```
** Here i see - we need to use first parameter as a Namespasem and second as a Resource Type - this is wrong way, if we will see at the code **

So, usage this script need to be like this:
bash ./scripts/kubeplugin <pod|node> <namespace>

I'll fix it and i'll do some refactoring to use this more comfortable.

#### How to use this script like a kubernetes plugin (I mean - you using Linux/MacOS).
**If you want** using kubectl plugin in the future - i propose using Krew as the plugin manager for kubectl command-line tool
```
Step one. Run this command to download and install krew:
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
)

Step two.
Add the following to your ~/.bashrc or ~/.zshrc:
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
Restart your shell (or open new termina window)
```
**If not** - just copying our script to path, which used in PATH env and neming this like `kubectl`-kubeplugin.
Eg:

	sudo cp ./scripts/kubeplugin /usr/local/bin/kubectl-kubeplugin
    sudo chmod +x /usr/local/bin/kubectl-kubeplugin
    kubectl plugin list

Now, you can using this plufin like a:

	> kubectl kubeplugin pod demo
            Resource            Namespace                                                             Name        CPU     Memory
                 pod                 demo                                      ambassador-5f859c79c9-hsj64        13m      148Mi
                 pod                 demo                                           cache-858575fc54-n67ct         2m        2Mi
                 pod                 demo                                              db-7968646c85-v488l         4m      357Mi
                 pod                 demo                                        demo-api-5479bcf989-8fxd7         1m        4Mi
                 pod                 demo                                      demo-ascii-548b45d685-glrl2         1m        5Mi
                 pod                 demo                                       demo-data-78b5b48794-4w989         1m        5Mi
                 pod                 demo                                      demo-front-548899b579-bp69n         1m        4Mi
                 pod                 demo                                        demo-img-5fd4bdf8bd-pr744         1m        5Mi
                 pod                 demo                                                      demo-nats-0         1m       14Mi
                 pod                 demo                                    demo-nats-box-f9c9b584c-zct4m         1m        0Mi
