Deploy quotes-flask with kubectl and see it working
In this exercise, we will go through the steps required to deploy a quotes-flask application using kubectl and integrate it with ArgoCD. By the end, you should be able to see your application running and interact with it via ArgoCD's user interface.

Objectives:
Getting your ArgoCD repository up and running.
Fork the provided repository.
Share the fork link with your trainer.
Trainer will add your fork to the main ArgoCD instance.
Understand and set up an "app of apps" to create URLs for each trainee. This is achieved using ArgoCD Application sets.
Access and explore the ArgoCD UI.
1. Forking the Repository
Duration: 10 minutes

Steps:

Navigate to the provided GitHub repository URL.
In the top-right corner of the page, click on the Fork button.
Once forked, you'll be redirected to your own copy of the repository.
Copy the URL of your forked repository.
Expected Outcome:
You should now have a personal copy of the repository on your GitHub account.

2. Send the Fork Link to the Trainer
Duration: 5 minutes

Steps:

Send the URL of your forked repository to your trainer using the preferred communication method.
Expected Outcome:
Your trainer should acknowledge the receipt of the link and proceed with the next steps.

3. Trainer Adds Your Repository
Duration: 10 minutes (This step is executed by the trainer)

Steps:

Trainer logs into the ArgoCD instance.
They navigate to Settings > Repositories.
Click on Connect Repo using HTTPS and paste the URL of the trainee's forked repository.
After adding, the repository should be listed under "Connected repositories."
Expected Outcome:
Your forked repository is now connected to ArgoCD.

4. Setting Up "App of Apps"
Duration: 20 minutes

Steps:

Familiarize yourself with the concept of ArgoCD's "app of apps" here.
Navigate to your forked repository.
Create or modify the necessary YAML files to represent an "app of apps" setup. This typically involves creating an Application resource for each trainee.
Ensure that each application points to the correct URL for the respective trainee.
Expected Outcome:
Each trainee should have their own application defined in the "app of apps" setup.

5. Access and Explore the ArgoCD UI
Duration: 15 minutes

Steps:

Open a browser and navigate to the provided ArgoCD instance URL.
Log in using the provided credentials.
Once logged in, you should see a list of applications, including the ones you just set up in the "app of apps."
Click on your application to see its details and status.
Expected Outcome:
You should be able to see the status of your quotes-flask application deployment and any other relevant details in the ArgoCD UI.

Note: Ensure all links and resources mentioned above are provided to the trainees to aid them in the exercise.

Good luck with your training session!
