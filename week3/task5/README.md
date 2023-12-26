# Creating Artifact Regiscry
gcloud artifacts repositories create k3s-k3d --repository-format=docker --location=europe-central2 --description="k3s-k3d" --immutable-tags --async

# greate image for different platform
Linux
TARGETARCH=amd64 make linux
TARGETARCH=arm64 make linux
TARGETARCH=arm64 make linux

MacOS
TARGETARCH=amd64 make darwin
TARGETARCH=arm64 make darwin
TARGETARCH=erm make darwin

Windows
TARGETARCH=amd64 make windows
