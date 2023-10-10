# Application Management with ArgoCD

## Learning Goals

- Update applications in ArgoCD.
- Understand the difference between Refresh and Sync in ArgoCD.
- Use the Diff feature in the ArgoCD UI.
- Update replicas using `kubectl` and understand the implications on the source of truth.
- Rollback to a previous application state.
- Troubleshoot and resolve issues with faulty manifests.

## Introduction

In this exercise, you will be diving deeper into the management of applications using ArgoCD. 

## Exercise

### Overview

In this exercise, you will:

- Update the `quotes-flask` application.
- Explore the difference between Refresh and Sync in ArgoCD.
- Use the Diff feature in the ArgoCD UI.
- Update replicas of the application using `kubectl`.
- Rollback to a previous state of the application.
- Troubleshoot a faulty manifest and resolve the issue.

**Understanding Refresh vs. Sync**

- **Refresh**: This action updates the live view in ArgoCD with the current state of the cluster. It does not change any resources in the cluster.
- **Sync**: This action deploys the desired state from the Git repository to the cluster. If there are differences between the Git repo and the cluster, Sync will make the necessary changes to align them.

### Step by Step Instructions

<details>
<summary>More Details</summary>

### Tasks

**Updating the Application**


* In the terminal, type `kubectl get all` to see that even though we have made the application manifest, the application is not yet deployed to the cluster.
* In the ArgoCD UI, select your `quotes-flask` application.
* Click on `Refresh` and observe that the live view is updated, but the application state remains unchanged.
* Click on `Sync` to deploy the changes you made in the repository to the cluster.
* In the terminal, type `kubectl get all` to see that the application is now deployed to the cluster.


**Using the Diff Feature in UI**

* After making another change in your GitHub repository (but before syncing), go to the ArgoCD UI.
* Select the `quotes-flask` application and click on `Diff`. This will show the differences between the live application and the desired state in the Git repository.

**Updating Replicas with `kubectl`**

* Use `kubectl` to scale the replicas of the `quotes-flask` application:

```bash
kubectl scale deployment frontend --replicas=3
```

* In the ArgoCD UI, notice that the application is now `OutOfSync` because the live state (3 replicas) differs from the desired state in the Git repository.

> :bulb: This demonstrates the importance of maintaining a single source of truth. Manual changes can cause drift from the desired state.

**Rolling Back Changes**

* In the ArgoCD UI, select the `quotes-flask` application.
* Navigate to the `History` tab.
* Choose a previous successful sync and click `Rollback` to revert the application to that state.

**Troubleshooting Faulty Manifests**

* Intentionally introduce an error in one of the Kubernetes manifests in your GitHub repository (e.g., a typo in a field name).
* Try to sync the application in ArgoCD. The sync will fail.
* In the ArgoCD UI, navigate to the `Events` tab for the `quotes-flask` application. Here, you can see detailed error messages that will help you identify the issue.
* Fix the error in the manifest, commit, and push the changes to the repository.
* Sync the application again in ArgoCD. The sync should now succeed.

</details>
