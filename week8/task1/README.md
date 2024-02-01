# This is HOWTO to using script for install and use pre-commit with gitleaks 

#### How to using script with command like a `curl pipe sh` but we will using `bash`
**This is can use some parameters (parameters can be combined):**
- install - will install pre-commit and gitleaks.
```
curl -sL https://raw.githubusercontent.com/ashyshka/GL-DevOps-Kubernetes/main/week8/task1/precommit.sh | bash -s install
```
- setup-globally - will setup it for all repositories, which will be cloned in the future.
```
curl -sL https://raw.githubusercontent.com/ashyshka/GL-DevOps-Kubernetes/main/week8/task1/precommit.sh | bash -s setup-globally
```
- setup-here - will setup only this repository (need to be in the root repository).
```
curl -sL https://raw.githubusercontent.com/ashyshka/GL-DevOps-Kubernetes/main/week8/task1/precommit.sh | bash -s setup-here
```
- check-here - will checking this repository with gitleaks and pre-commit (need to be in the root repository and pre-commit and gitleaks need to be installed).
```
curl -sL https://raw.githubusercontent.com/ashyshka/GL-DevOps-Kubernetes/main/week8/task1/precommit.sh | bash -s check-here
```
