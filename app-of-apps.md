# Organizing and Managing Argo CD Apps through app-of-apps

## Learning Goals

- Create a bootstrap app manifest
- Arrange Argo CD app manifests in a folder structure

## Introduction

In this exercise, we will work on organizing and managing Argo CD applications more effectively. We will create a bootstrap app manifest to serve as a starting point, structure our repository to accommodate multiple apps, and work with a new app manifest for a Helm chart.

## Exercise

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

1. Navigate to the root of your local clone of the exercise repository.
2. Create a file named `bootstrap-app.yaml` with the following content:

:bulB: NB! Make sure to replace the placeholders with your own values.

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: bootstrap-<YOURNAME>
  namespace: argocd
spec:
  destination:
    server: https://kubernetes.default.svc
    namespace: <YOUR NAMESPACE>
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

## Step 2: Create Folder for All Apps

1. In the root of your repository, create a new folder named `apps`.

## Step 3: Move Jenkins App Manifest

1. Locate the Jenkins app manifest in your repository.
2. Move the Jenkins app manifest into the `apps` folder you created in the previous step.

## Step 4: Create the App Manifest for the Quotes Helm Chart

1. In the `apps` folder, create a file named `quotes-app.yaml` with the following content:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: quotes
  namespace: argocd
spec:
  destination:
    server: https://kubernetes.default.svc
    namespace: <YOUR NAMESPACE>
  project: default
  source:
    repoURL: https://github.com/eficode-academy/argocd-katas.git  # Update this URL if the helm chart is in a different repo
    targetRevision: HEAD
    path: charts/quotes
    helm:
      valueFiles:
        - values.yaml
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```

## Step 5: Apply and Re-Apply the Bootstrap App


2. Verify the applications are synced and running as expected.

3. Delete the bootstrap app from your cluster:

```bash
kubectl delete -f bootstrap-app.yaml
```

4. Verify that the applications and resources are removed.

5. Re-apply the bootstrap app manifest to your cluster:

```bash
kubectl apply -f bootstrap-app.yaml
```

6. Verify the applications are synced and running as expected again.

</details>

## Conclusion

In this exercise, you learned how to organize Argo CD app manifests within a repository, create a new app manifest for a Helm chart, and utilize sync, prune, and self-heal features to maintain the desired state in your Kubernetes cluster. This structure and practices will help you manage and operate your applications more effectively with Argo CD.