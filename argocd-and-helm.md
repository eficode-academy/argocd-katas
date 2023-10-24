# Exercise: Deploying helm charts with Bitnami

## Learning Goals

- Deploy WordPress using Helm with custom values.
- Modify Helm values for customization.
- Put helm values in a values file utilizing multi-source.

## Introduction


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
- Change your manifest to use the `values.yaml` file by adding the following to the `spec.source.helm.parameters` section:

``` yaml
```



</details>


Now you have an exercise that guides users through deploying WordPress with Helm, customizing the deployment, and observing the changes. Users will gain hands-on experience with Helm, Kubernetes manifests, and value customization.