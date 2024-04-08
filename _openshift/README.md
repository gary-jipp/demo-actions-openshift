# Openshift CLI

Use these scripts to perform the initial OpenShift setup and initial deployment.  Subsequent builds and deployments triggered by GitHub Actions.

#### OC Command line: easy but less control
```bash
oc login --token=<your token> --server=<your server>
oc new-build --name=demo-express --strategy=docker --code=<github repo>
oc new-app demo-express:latest
oc expose service/demo-express
```

#### OC Command line: use yaml files
```bash
oc login --token=<your token> --server=<your server>  # Login with credentials
oc get imagestreams             # See what images we have registered
oc create imagestream demo-express  # Create an IS for our build if needed
oc apply -f 1-buildconfig.yaml  # Create the buildconfig for the image
oc apply -f 2-deployment.yaml   # Create deployment
oc apply -f 3-service.yaml      # Add Service for this deployment
oc apply -f 4-route.yaml        # Create a route to expose the service
```

## Create everything using a template
```bash
oc process -f demo-express.yaml  |  oc apply -f -
```

## trigger an image build
```bash
oc start-build demo-express
```

```bash
## add redeploy trigger for when image changes
oc set triggers deploy/demo-express --from-image=demo-express:latest -c demo-express
```
