# Exercise: Deploying helm charts with Bitnami

## Learning Goals

- Deploy WordPress using Helm with custom values.
- Modify Helm values for customization.
- Put helm values in a values file utilizing multi-source.

## Introduction

### Multi-source in ArgoCD

<details>
<summary>:bulb: Example</summary>

```yaml

# Reference to the project name.
project: default

# Define the destination cluster for this application.
destination:
  # The namespace the application should be deployed to.
  namespace: student-X
  # Specify the name of the destination cluster, either name or server url.
  name: in-cluster

# Define the synchronization policy for the Application.
syncPolicy:
  automated: {}

# Define where the application will fetch its source from.
sources:
  # Specify the repository URL for the Helm chart.
  - repoURL: 'https://charts.bitnami.com/bitnami'
    # Specify the target revision of the helm repository.
    targetRevision: 18.0.8
    # Specify the name of the Helm chart as "wordpress".
    chart: wordpress
    helm:
      # Reference the values file for the Helm chart in another repository.
      valueFiles:
        # Include a values file from a location specified by a variable "$values".
        - $values/wordpress/values.yaml

    # Specify the second source; URL for the Git repository.
  - repoURL: 'https://github.com/<YOUR GIT REPO>/argocd-katas'
    # Specify the branch of the Git repository.
    targetRevision: main
    # name this source "values" for reference in the above source.
    ref: values

```
</details>

## Exercise

### Overview

In this exercise, you will:


### Step by Step Instructions

<details>
<summary>More Details</summary>

### Tasks

**Deploying WordPress with Bitnami Helm**
- Look into the repository site to see that a repository called `bitnami` with the URL `https://charts.bitnami.com/bitnami` is there.
- Click on `Applications` in the navigation bar.
- Click on `New App` to create a new application.
- Fill in the following details:
  - **Application Name**: <your name>-quotes-flask
  - **Project Name**: `default`
  - **Sync Policy**: `Automatic`
  - **Repository Type**: `Helm`
  - **Repository URL**: https://charts.bitnami.com/bitnami (or select from the dropdown)
  - **Chart**: `wordpress`
  - **Version**: `18.0.8`
  - **Cluster**: `in-cluster` or `https://kubernetes.default.svc`
  - **Namespace**: <your namespace>

Under the helm parameters, you can see that there are a lot of parameters that can be customized. We will be customizing one of them.

- Find `service.type` and change it to `NodePort`.
- Click on `Create`.

- Click on the application to see the details.
- Find the nodeport by clicking on the `studentx-wordpress` service.
- Access the WordPress site by going to `http://<node-ip>:<nodeport>`. You can find the external node IP by running `kubectl get nodes -o wide`.

**Customizing the WordPress deployment with a values file**
We will change the values of the WordPress deployment by using a values file. This is useful when you want to keep your values in a separate file and not in the ArgoCD UI.

- Save the current application manifest to your repository by clicking `App details` and then `Manifest`. It should be saved in the `wordpress` directory.
- Look at the `values.yaml` file in the `wordpress` directory. You can see that the `service.type` is set to `NodePort`.
- Change your manifest to use the `values.yaml` file by changing `spec.source` to `spec.sources` like the following:

``` yaml
project: default
destination:
  namespace: student-X
  name: in-cluster
syncPolicy:
  automated: {}
sources:
  - repoURL: 'https://charts.bitnami.com/bitnami'
    targetRevision: 18.0.8
    helm:
      valueFiles:
        - $values/wordpress/values.yaml
    chart: wordpress
  - repoURL: 'https://github.com/<YOUR GIT REPO>/argocd-katas'
    targetRevision: main
    ref: values
```

- Click save.

> :bulb: it might be so that the Argo UI breaks when you click save. This is because the multi source feature is still in beta. If this happens, you can just refresh the page and it should be fine.

- Try to change something in the `values.yaml` file, push it up, and see that the application is synced automatically. If you lack inspiration, you can change the `service.type` to `ClusterIP` and see that the service is now a ClusterIP service.



</details>

