# Introduction to ArgoCD

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

- **Refresh**: This action updates the live view in ArgoCD with the current state of the cluster and the state of the git repo. It does not change any resources in the cluster.
- **Sync**: This action deploys the desired state from the Git repository to the cluster. If there are differences between the Git repo and the cluster, Sync will make the necessary changes to align them.

### Step by Step Instructions

<details>
<summary>More Details</summary>

### Tasks

**Updating the Application**


* In the terminal, type `kubectl get all` to see that even though we have made the application manifest, the application is not yet deployed to the cluster.
* In the ArgoCD UI, select your `quotes-flask` application.
* Click on `Refresh` and observe that the live view is updated, but the application state remains unchanged.
* Click on `Sync` and confirm with `Synchronize` to deploy the changes you made in the repository to the cluster.
* Notice how all the resources in the UI are now turning from yellow to green, indicating that the application is in a healthy state.
* In the terminal, type `kubectl get all` to see that the application is now deployed to the cluster.

```bash
NAME                            READY   STATUS    RESTARTS   AGE
pod/backend-5cd66f88c-bp6xz     1/1     Running   0          8m2s
pod/frontend-6776498dd8-hrjwj   1/1     Running   0          8m2s
pod/postgres-7bc8b45445-btdkx   1/1     Running   0          8m2s

NAME               TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
service/backend    ClusterIP   10.100.168.124   <none>        5000/TCP         8m2s
service/frontend   NodePort    10.100.105.77    <none>        5000:30248/TCP   8m2s
service/postgres   ClusterIP   10.100.249.10    <none>        5432/TCP         8m2s

NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/backend    1/1     1            1           8m2s
deployment.apps/frontend   1/1     1            1           8m2s
deployment.apps/postgres   1/1     1            1           8m2s

NAME                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/backend-5cd66f88c     1         1         1       8m2s
replicaset.apps/frontend-6776498dd8   1         1         1       8m2s
replicaset.apps/postgres-7bc8b45445   1         1         1       8m2s
```


**Using the Diff Feature in UI**

* Make a change to the `quotes-flask` application in your GitHub repository
    * Change the replica count of the `frontend` deployment to `2`.
    * Commit and push the changes to the repository.
* Go to the ArgoCD UI.
    * Select the `quotes-flask` application and click on `Refresh`. This will update the live view in ArgoCD with the current state of the cluster.
    * Click on `Diff`. This will show the differences between the live application and the desired state in the Git repository. If the full diff is too long, you click on the `compact diff` button to see a summary of the changes.
    * Click on `Sync` and confirm with `Synchronize` to deploy the changes you made in the repository to the cluster.

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

This can be handy as a quick way to revert changes that were made in error. However, it is not a replacement for a proper GitOps workflow. In a GitOps workflow, you would revert the changes in the Git repository and then sync the application in ArgoCD.

In the later exercises, we will automate the sync process, making ArgCD revert the changes automatically.

**Testing Self-Heal Policy**

* In the ArgoCD UI, select the `quotes-flask` application.
* Click on `app details` and click on `Edit`.
* Scroll down to `sync policy` and enable that.
* Use `kubectl` to make a change to the `quotes-flask` application (e.g., scale the replicas to 4):

   ```bash
   kubectl scale deployment frontend --replicas=4
   ```

* Verify that there are four replicas:

   ```bash
   kubectl get pods
   ```
* In the ArgoCD UI, notice that the application is now `OutOfSync` because the live state (4 replicas) differs from the desired state in the Git repository.

* In the ArgoCD UI, select the `quotes-flask` application.

* Then enable the `Self Heal` section under `Sync Policy` and click on `Save`.

Now, if you make a change to the application using `kubectl`, ArgoCD will automatically revert the change to the desired state defined in the Git repository.

* Use `kubectl` to see that ArgoCD has reverted the change:
```bash
kubectl get pods
NAME                        READY   STATUS    RESTARTS   AGE
backend-5cd66f88c-mchxn     1/1     Running   0          20h
frontend-6776498dd8-xwjpq   1/1     Running   0          20h
frontend-6776498dd8-zfw5l   1/1     Running   0          20h
postgres-7bc8b45445-kshd8   1/1     Running   1          20h
```

**Troubleshooting Faulty Manifests**

* Intentionally introduce an error in one of the Kubernetes manifests in your GitHub repository (e.g., a typo in a field name).
* Try to sync the application in ArgoCD. The sync will fail.
* In the ArgoCD UI, navigate to the `Events` tab for the `quotes-flask` application. Here, you can see detailed error messages that will help you identify the issue.
* Fix the error in the manifest, commit, and push the changes to the repository.
* Sync the application again in ArgoCD. The sync should now succeed.

</details>

