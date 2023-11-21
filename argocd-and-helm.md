# Exercise: Deploying helm charts with Bitnami

## Learning Goals

- Deploy Jenkins using Helm with custom values.
- Modify Helm values for customization.
- Put helm values in a values file utilizing multi-source.

## Introduction

### Multi-source deployment in ArgoCD

<details>
<summary>:bulb: Example</summary>

```yaml

apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: student-0-jenkins
  namespace: argocd
spec:
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
      targetRevision: 12.4.0
      # Specify the name of the Helm chart as "Jenkins".
      chart: jenkins
      helm:
        # Reference the values file for the Helm chart in another repository.
        valueFiles:
          # Include a values file from a location specified by a variable "$values".
          - $values/jenkins/values.yaml

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

- Deploy Jenkins in the ArgoCD UI using Bitnami Helm chart.
- Change the source of the deployment file.
- Write a multi-source deployment file.
- Change the values in the deployment file for automatic changes to the Jenkins app.


### Step by Step Instructions

<details>
<summary>More Details</summary>

### Tasks

**Deploying Jenkins with Bitnami Helm**
- Look into the repository site to see that a repository called `bitnami` with the URL `https://charts.bitnami.com/bitnami` is there.
- Click on `Applications` in the navigation bar.
- Click on `New App` to create a new application.
- Fill in the following details:
  - **Application Name**: `<your name>-jenkins`
  - **Project Name**: `default`
  - **Sync Policy**: `Automatic`
  - **Repository Type**: `Helm`
  - **Repository URL**: https://charts.bitnami.com/bitnami (or select from the dropdown)
  - **Chart**: `Jenkins`
  - **Version**: `12.4.0`
  - **Cluster**: `in-cluster` or `https://kubernetes.default.svc`
  - **Namespace**: `<your namespace>`

Under the helm parameters, you can see that there are a lot of parameters that can be customized. We will be customizing one of them.

![alt](img/jenkins-values.png)

- Find `service.type` and change it to `NodePort`.
- Find `persistence.enabled` and change it to `false`.
- Find `jenkinsPassword` and change it to `student`.
- Click on `Create`.

- Click on the application to see the details.
- Find the http nodeport by clicking on the `studentx-jenkins` service.
- Access the Jenkins site by going to `http://<node-ip>:<nodeport>`. You can find the external node IP by running `kubectl get nodes -o wide`.

**Customizing the Jenkins deployment with a values file**
We will change the values of the Jenkins deployment by using a values file. This is useful when you want to keep your values in a separate file and not in the ArgoCD UI.

- Look at the `values.yaml` file in the `jenkins` directory. You can see that the `service.type` is set to `NodePort`, and two other values.
- Now find the manifest in the ArgoCD UI by clicking on `app details`.
- Change your manifest in ArgoCD in to use the `values.yaml` file by changing `source` to `sources` like the following:

``` yaml
project: default
destination:
  namespace: student-X
  name: in-cluster
syncPolicy:
  automated: {}
sources:
  - repoURL: 'https://charts.bitnami.com/bitnami'
    targetRevision: 12.4.0
    helm:
      valueFiles:
        - $values/jenkins/values.yaml
    chart: jenkins
  - repoURL: 'https://github.com/<YOUR GIT REPO>/argocd-katas'
    targetRevision: main
    ref: values
```
💡 Remember to add your own repo to the file as well, as seen on the bottom. Pay attention to formatting.

- Click save.

> :bulb: Argo UI may break when you click save. This is because the multi source feature is still in beta. If this happens, you can just refresh the page and it should be fine.

![Jenkins sync problems](img/jenkins-app-sync-problem.png)

> :bulb: It might also be that the application has a hard time syncing the new pod. You can try to delete the replica set and see if it works. If not, you can delete the application and try again.


- Try to change something in the `values.yaml` file, push it up, and see that the application is synced automatically. If you lack inspiration, you can change the `service.type` to `ClusterIP` and see that the service is now a ClusterIP service.

</details>

