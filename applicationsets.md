# Application sets

## Learning Goals

- Trying out a pull request based application set

## Introduction

In this exercise we will try out a pull request based application set. We will try to create an application set that will create an application for each pull request in a repository.

## Application set

The sole responsibility of the ApplicationSet controller is to create, update, and delete `Application` resources within the Argo CD namespace. The controller's only job is to ensure that the Application resources remain consistent with the defined declarative ApplicationSet resource, and nothing more.

Thus the ApplicationSet controller does not create/modify/delete Kubernetes resources (other than the Application CR)

## Exercise

### Overview

- Create an applicationset manifest
- Test with a pull request
- Close the pull request

### Step by step instructions

<details>
<summary>More Details</summary>

#### Create an applicationset manifest

In the `applicationsets` directory create a file called `pull-request.yaml` with the following content:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: ApplicationSet
metadata:
  name: pr-<NUMBER>
  namespace: argocd
spec:
  generators:
  - pullRequest:
      github:
        # The GitHub organization or user.
        owner: <YOUR GITHUB USERNAME> #e.g. eficode-academy
        # The Github repository
        repo: <YOUR GIT REPO> #e.g. argocd-katas

        # Labels is used to filter the PRs that you want to target. (optional)
        labels:
        - test
      requeueAfterSeconds: 180
  template:
    metadata:
      name: 'todo-<NUMBER>-{{branch}}-{{number}}'
    spec:
      project: "default"
      source:
        repoURL: 'https://github.com/eficode-academy/helm-katas.git'
        targetRevision: 'main'
        path: examples/apps/http-server
        helm:
          parameters:
          - name: containerPort
            value: "3000"
          - name: image.repository
            value: releasepraqma/todo-app
          - name: image.tag
            value: latest
          - name: prefix
            value: argo
          - name: app
            value: "todo-{{head_short_sha}}"
      destination:
        server: https://kubernetes.default.svc
        namespace: <YOUR NAMESPACE>
      syncPolicy:
        automated:
          prune: true
          selfHeal: true
```

* edit the file and replace
    * `<YOUR GITHUB USERNAME>` with your github username
    * `<YOUR GIT REPO>` with your git repo
    * `<YOUR NAMESPACE>` with your namespace
    * `<NUMBER>` with your number (student-X)

* Apply the manifest

```bash
kubectl apply -f applicationsets/pull-request.yaml
```


#### Test with a pull request

* Create a pull request in your git repo. The change does not matter at this time, since we are not using the source code in the pull request.

* Remember to set the label `test` on the pull request.

* Check that an application has been created in ArgoCD

```bash
kubectl get applications -n argocd
```

* Check that an application has been created in your namespace

```bash
kubectl get pods -n <YOUR NAMESPACE>
```

* Get your ingress hostname

```bash
kubectl get ingress -n <YOUR NAMESPACE>
```

* Access the application in your browser (remember to add https:// in front of the hostname)

You should see something like the follwing:

![the todo application](img/todo-app.png)

#### Close the pull request

* now close the pull request, and see that the application is deleted from ArgoCD

```bash
kubectl get applications -n argocd
```

</details>

### Clean up

* Delete the applicationset

```bash
kubectl delete -f applicationsets/pull-request.yaml
```

#### Further reading

* [ApplicationSet](https://argocd-applicationset.readthedocs.io/en/stable/)
* [ApplicationSet Generators](https://argocd-applicationset.readthedocs.io/en/stable/Generators/)
* [ApplicationSet Templates](https://argocd-applicationset.readthedocs.io/en/stable/Template/)

