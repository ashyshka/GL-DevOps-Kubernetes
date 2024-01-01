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
** Here i see - we need to use first parameter as a Namespasem and second as a Resource Type **

So, usage this script need to be like this:
bash ./scripts/kubeplugin [pod|node] [namespace]

I'll fix it and i'll do some refactoring to use this more comfortable.


