# Folder per env

An app manifest and a values file per application in the environment.

Pros:
- Clear separation of environments
- Easy to understand
- Easy to get an overview of what is deployed where
    - `tree . -L 2` gives a good overview

Cons:
- Application manifests are "bleeding" into dev environment