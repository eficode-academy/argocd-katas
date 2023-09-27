# Argo CD - Bootstrap

This is the folder where the bootstrap of the cluster is defined. This includes the ArgoCD application that will deploy the rest of the cluster.

## installation

### Prerequisites

Before running this script, ensure that you have the following prerequisites:

- `kubectl` CLI installed and configured to connect to your Kubernetes cluster.
- Access to the cluster with sufficient privileges to create namespaces, apply configurations, and patch services. Usually the computer who created the cluster will have that access.

### Usage

1. For the repository for this specific training.

2. Modify the script if needed:
   - Update the `ARGO_CD_VERSION` variable if you want to install a different version of Argo CD.

1. Modify the argo ingress part under `tools/argo-cd/argo-ingress.yaml` if needed:
   - Update the `host` value to match your prefix name.

3. Make the script executable:
   ```shell
   chmod +x script.sh
   ```

4. Run the script:
   ```shell
   ./script.sh
   ```

## Repositories

This folder includes the repository secrets that ArgoCD uses.
ArgoCD repository credentials are used to securely authenticate and authorize access to repositories. 
They allow ArgoCD to retrieve application manifests or configuration files from Bitbucket,Azure Container registry and the likes.
By providing the necessary credentials, ArgoCD can establish a secure connection and keep applications in sync with the Git repository.
They will be installed by the `install.sh` script.

