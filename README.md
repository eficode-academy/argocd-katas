# argocd-katas

Exercise list in order:

* [Setup of your ArgoCD root application](setup.md)
* [Introduction to ArgoCD](intro.md)
* [ArgoCD And Helm](argocd-and-helm.md)
* [App of Apps](app-of-apps.md)
* [ApplicationSets](applicationsets.md)
* [Sealed Secrets](sealed-secrets.md) (Not done yet)

## Using this outside of the workshop

You need to have ArgoCD installed and running.
All exercises should work on minikube, or kind.
You can refer to the [installation link](https://argo-cd.readthedocs.io/en/stable/operator-manual/installation/) for how to install ArgoCD.

## Repository Structure

The repository is structured as follows:

```text
.
├── applicationsets # Values for 5-applicationsets.md
├── 5-applicationsets.md
├── 4-app-of-apps.md  
├── 3-argocd-and-helm.md
├── img
├── 2-intro.md
├── jenkins # Values for the Jenkins Helm Chart
├── LICENSE
├── quotes-flask # Example application
├── README.md
├── sealed-secrets.md
├── 1-setup.md
└── trainer # Trainer folder
```


Links:

https://codefresh.io/blog/argo-cd-best-practices/
https://github.com/akuity/awesome-argo/blob/main/CONTRIBUTING.md
