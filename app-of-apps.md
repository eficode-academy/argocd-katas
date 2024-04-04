# Organizing and Managing Argo CD Apps through app-of-apps

## Learning Goals

- Create a bootstrap app manifest
- Arrange Argo CD app manifests in a folder structure

## Introduction

In this exercise, we will work on organizing and managing Argo CD applications more effectively. We will create a bootstrap app manifest to serve as a starting point, structure our repository to accommodate multiple apps, and work with a new app manifest for a Helm chart.

## Exercise

### Overview

- Create Bootstrap App Manifest
- Create Folder for All Apps
- Move Jenkins App Manifest
- Create the App Manifest for the Quotes Helm Chart

### Step by step instructions

<details>
<summary>More Details</summary>

* Create bootsrap app manifest
* Create folder for all apps in the repo
* Move Jenkins app manifest to the folder
* Create the app manifest for the quotes helm chart located in the same repo. (OR IN THE OTHER REPO TODO)
  * Enable sync policy, prune and self-heal
* kubectl delete parent app, make sure nothing is there. kubectl apply parent app again. 


## Step 1: Create Bootstrap App Manifest

1. On your workstation vs-code:
2. Create a file named `bootstrap-app.yaml` anywhere, with the following content:

:bulb: NB! Make sure to replace the placeholders with your own values.

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: bootstrap-student-<YOURNUMBER>
  namespace: argocd
  finalizers:
    - resources-finalizer.argocd.argoproj.io
spec:
  destination:
    server: https://kubernetes.default.svc
    namespace: student-<YOURNUMBER>
  project: default
  source:
    repoURL: <YOUR GITHUB REPO>
    targetRevision: HEAD
    path: apps
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```

1. Apply the bootstrap app manifest to your cluster:

```bash
kubectl apply -f bootstrap-app.yaml
```

1. Go to the Argo CD UI and verify that the bootstrap app is present. It should have an error saying that it cannot find the `apps` folder. This is expected.

## Step 2: Create Folder for All Apps, and add Jenkins App Manifest to it.

Save the current application manifest to your repository in a new folder named `apps`.

- Get the Jenkins application manifest from the Argo CD UI:
  - click `App details` and then `Manifest`.
  - It does not have the entire manifest, but it has the spec part.
  - It should be saved in the `apps` directory in your repository.
  - Name it `jenkins-app.yaml`.

<details>
<summary>:bulb: Help me out</summary>

The file that you will be saving looks like this, with the `<NUMBER>` being your student number and `<YOUR GIT REPO>` being your repository URL:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: student-<NUMBER>-jenkins
  namespace: argocd
spec:
  project: default
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
  destination:
    server: 'https://kubernetes.default.svc'
    namespace: student-<NUMBER>
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```
</details>

- Add, commit and push the jenkins-app.yaml to the repository.
- Go to the Argo CD UI and verify that the bootstrap app is present. It should now be updated to include the `apps` folder, and therefore the Jenkins app manifest.

Now the jenkins app is connected with the bootstrap app.

## Delete the jenkins app

- In the Argo CD UI, delete the jenkins app.
- What happens when you do that?


## Create the App Manifest for the Quotes Helm Chart

1. In the `apps` folder, create a file named `quotes-app.yaml` with the following content:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: quotes-student-<YOURNUMBER>
  namespace: argocd
spec:
  destination:
    server: https://kubernetes.default.svc
    namespace: student-<YOUR number>
  project: default
  source:
    repoURL: https://github.com/eficode-academy/argocd-katas.git  # Update this URL if the helm chart is in a different repo
    targetRevision: HEAD
    path: quotes-flask/helm/quotes-flask
    helm:
      valueFiles:
        - values.yaml
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```

- Click refresh in the Argo CD UI. The quotes app should now be present as an application in Argo CD.
- Click on the quotes app to see all the resources that it creates.

## Apply and Re-Apply the Bootstrap App

1. Verify the applications are synced and running as expected.

1. Delete the bootstrap app from your cluster:

```bash
kubectl delete -f bootstrap-app.yaml
```

1. Verify that the applications and resources are removed.

```bash
kubectl get all
```

1. Re-apply the bootstrap app manifest to your cluster:

```bash
kubectl apply -f bootstrap-app.yaml
```

1. Verify the applications are synced and running as expected again.

You have now seen how fast it is to reapply your manifests to the cluster. This is a great way to recover from a disaster, or to make sure that your cluster is in the desired state.

</details>

## Conclusion

In this exercise, you learned how to organize Argo CD app manifests within a repository, create a new app manifest for a Helm chart, and utilize sync, prune, and self-heal features to maintain the desired state in your Kubernetes cluster. This structure and practices will help you manage and operate your applications more effectively with Argo CD.
