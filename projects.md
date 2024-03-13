# ArgoCD project

## Learning Goals

- Introduction to the appproject manifest
- Examine the restrictions you can make with the appprojects

## Introduction

Argo CD `projects` logically group applications for multiple teams, providing deployment restrictions to things like source repos, destination clusters/namespaces, resource definitions etc. 
The default project that comes baked in to ArgoCD allows unrestricted deployments. 
New projects should be created for team-specific access levels, managing source repos, destinations, and Kubernetes resource kinds.
Projects can be created with either Argo CD cli or declaratively.


An `AppProject` is a custom resource definition (CRD) that defines a project in Argo CD. An example of an `AppProject` is shown below:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: AppProject # kind of the resource
metadata:
  name: team-awesome # name of the project
  namespace: argocd # namespace where the resource is created
spec:
  description: Team Awesome # description of the project in the UI
  destinations:
  - name: in-cluster
    namespace: student-0 # namespace where applications from this project can be deployed
    server: https://kubernetes.default.svc # server where the applications can be deployed
  sourceRepos:
  - https://github.com/eficode-academy/argocd-katas.git # source repository where the applications can be deployed from
```

## Exercise

We are going to try out restrictions with the `appproject` kind. We will apply an application manifest that violates different restrictions, leading to errors in the deployment of the application.

### Overview

* create a project manifest
* apply the project manifest
* apply the application manifest that violates the restrictions
* choose selective sync to partially sync the application


### Step by step instructions

**Create a project manifest**

Look at the file [project.yaml](projects/project.yaml) in the projects folder. It looks like the following:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: student-x-project # remember to change this!
  namespace: argocd
spec:
  description: A project for student-x to play with # remember to change this!
  destinations:
    - name: in-cluster
      namespace: student-x #remember to change this!
      server: https://kubernetes.default.svc
  namespaceResourceBlacklist:
    - group: rbac.authorization.k8s.io
      kind: Role
  sourceRepos:
    - https://github.com/eficode-academy/argocd-katas.git

```

It is a simple project manifest that restricts the deployment to a specific namespace and restricts the deployment of `Role` resources.

- change the `name`, `spec.description` and `spec.destinations.namespace` fields to your student number

**Apply the project manifest**

```bash
kubectl apply -f projects/project.yaml
```

- check that the project was created successfully

```bash
kubectl get appproject -n argocd
```

You should see something like this in the output (there might be many more projects):

```bash
kubectl get appproject -n argocd
NAME                AGE
default             23h
student-x-project   3m18s
```

Go to the ArgoCD UI and see the project from there as well.

- Click on `Settings` -> `Projects` and you should see the project there
- Click on the project and see the details. Here you can see the different options that can be set for the project.
- Verify that the description reflects your student number as well, e.g `a project for student-0 to play with`

**Apply the application manifest that violates the restrictions**

- Open the file [application.yaml](projects/application.yaml) in the projects folder. It looks like the following:
```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: student-x-quotes-flask # remember to change this!
  namespace: argocd
spec:
  project: student-x-project # remember to change this to your project name!
  source:
    repoURL: 'https://github.com/eficode-academy/argocd-katas.git'
    path: quotes-flask/k8s
    targetRevision: HEAD
  destination:
    server: 'https://kubernetes.default.svc'
    namespace: student-x # remember to change this to your namespace!
```
- Change the `name`, `spec.project` and `spec.destination.namespace` fields to your student number.
- Apply the application manifest

```bash
kubectl apply -f projects/application.yaml
```

- Go to the UI to see that it is created.
- Click sync and see the error in the logs.

The project restricts the deployment of `Role` resources, so the application will not be deployed successfully.

**Choose selective sync to partially sync the application**

- Click on the application in the UI
- Click on `Sync` and in the list of resources, uncheck the `Role` resource
- Click `Syncronize` and see that the application is deployed successfully (except for the `Role` resource)

### Optional: Create an application outside your namespace

If time permits, try to create an application that is deployed to a namespace that is not allowed by the project.  
>  **NOTE:** Don't do this by simply manipulating the destination of the application you just applied as that will 
> potentially interfere with the other students exercises. 

What are the differences in the error messages, compared to the previous application?


### Clean up

To clean up the resources created in this exercise, run the following commands:

```bash
kubectl delete -f projects 
```

