# Openshift CLI

Use Template to perform the initial OpenShift setup and initial deployment.  Subsequent builds and deployments triggered by GitHub Actions.  Openshift token must be saved as a GitHub Action secret for this repo.

##
## 1. Common Setup

### Openshift: Create/update ImageStreams (source & destination)
```bash
oc project <image ns>
oc process -f image.yaml  |  oc apply -f -
oc describe is/node
oc describe is/demo-express
```
### Set policy to allow runtime namespace to pull from image namespace
```bash
oc policy add-role-to-user system:image-puller system:serviceaccount:<runtime ns>:default -n=<image ns>
```

### Create Deployment in the runtime namespace
```bash
oc project <runtime image namespace>
oc process -p IMAGE_NS=<image ns> -f demo-express.yaml  |  oc apply -f -
```

##
## 2. Build Image on GitHub & Push to OpenShift

### GitHub: Create Action Secrets
- `OPENSHIFT_REGISTRY`   : image-registry.apps.silver.devops.gov.bc.ca
- `OPENSHIFT_NAMESPACE`  : Namespace that contains the ImageStream
- `OPENSHIFT_TOKEN`      :tokrn for service account (see below)

### Run GitHub Action "OpenShift Connection Test"
Confirm Action runs without errors and logs into your OpenShift

### Run GitHub Action "Build on GitHub & Push to OpenShift"

## add redeploy trigger for when image changes
## Not needed with this template, already included
```bash
oc set triggers deploy/demo-express --from-image=demo-express:latest -c demo-express
```

## Generate / fetch OpenShift token for GitHub actions.  Allows GitHub Action to push the image
```bash
 oc get secrets

# create service account (if not already there)
oc create serviceaccount github-action-sa
oc policy add-role-to-user edit -z github-action-sa -n <image ns>

# Find token secret for service account
 oc get secrets

# Get token as base64 to save as GitHub Actions Secret
oc get secret github-action-sa-token-xxxx -o jsonpath='{.data.token}' | base64 --decode

```