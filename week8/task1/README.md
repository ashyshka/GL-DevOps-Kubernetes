# This is HOWTO yo using script for install and use pre-commit with gitleaks 

- Download script for local usage
```
curl -sL https://raw.githubusercontent.com/ashyshka/GL-DevOps-Kubernetes/main/week8/task1/precommit.sh > precommit.sh
```
- Using script with commend like a `curl pipe sh`
```
curl -sL https://raw.githubusercontent.com/ashyshka/GL-DevOps-Kubernetes/main/week8/task1/precommit.sh | sh -s install
curl -sL https://raw.githubusercontent.com/ashyshka/GL-DevOps-Kubernetes/main/week8/task1/precommit.sh | sh -s setup-globally
curl -sL https://raw.githubusercontent.com/ashyshka/GL-DevOps-Kubernetes/main/week8/task1/precommit.sh | sh -s setup-here
curl -sL https://raw.githubusercontent.com/ashyshka/GL-DevOps-Kubernetes/main/week8/task1/precommit.sh | sh -s check-here
```
