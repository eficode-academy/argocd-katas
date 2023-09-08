# Deploy `quotes-flask` with `kubectl` and see it working

## Learning Goals

- Fork and manage repositories in GitHub.
- Understand and utilize ArgoCD repositories.
- Familiarize with the "app of apps" setup in ArgoCD.
- Navigate and interact with the ArgoCD UI.

## Introduction

In this exercise, you will be deploying the `quotes-flask` application using `kubectl` and integrating it with ArgoCD. This will give you hands-on experience with application deployment and management in ArgoCD.

## Subsections

- **Forking the Repository**
- **Sharing the Fork with Trainer**
- **Setting up "App of Apps"**
- **Exploring the ArgoCD UI**

<details>
<summary>:bulb: About ArgoCD</summary>

ArgoCD is a declarative, GitOps continuous delivery tool for Kubernetes. It facilitates the management and deployment of applications within Kubernetes using Git repositories as the source of truth for defining the desired application state.

</details>

## Exercise

### Overview

- Fork the provided repository.
- Share the forked repository link with your trainer.
- Setup an "app of apps" within ArgoCD.
- Access and familiarize with the ArgoCD UI.

### Step by Step Instructions

<details>
<summary>More Details</summary>

**Forking the Repository**

- Navigate to the provided GitHub repository URL.
- In the top-right corner of the page, click on the `Fork` button. This creates a personal copy of the repository on your GitHub account.
- Copy the URL of your forked repository.

> :bulb: The forked repository acts as your personal workspace where you can make changes without affecting the original project.

**Sharing the Fork with Trainer**

- Send the URL of your forked repository to your trainer using the preferred communication method.
  
> :bulb: The trainer will use this link to integrate your repository with ArgoCD.

**Setting up "App of Apps"**

- Familiarize yourself with the concept of ArgoCD's "app of apps" [here](<Insert Link to Documentation or Resource>).
- Navigate to your forked repository.
- Create or modify the necessary YAML files to represent an "app of apps" setup.
  
> :bulb: This step involves creating an `Application` resource for each trainee and pointing to the correct URL.

**Exploring the ArgoCD UI**

- Open a browser and navigate to the provided ArgoCD instance URL.
- Log in using the provided credentials.
- Click on your application to see its details and status.

> :bulb: The ArgoCD UI provides a visual representation of your deployments and their current states.

</details>

### Clean Up

- If you made any temporary changes or created temporary files during the exercise, ensure to remove or revert them to keep your workspace clean.
- Logout from the ArgoCD UI.

