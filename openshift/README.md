# Openshift CLI

Use these scripts to perform the initial OpenShift setup and initial deployment.  Subsequent builds and deployments triggered by GitHub Actions.

#### OC Command line: easy but less control
``` bash
oc login --token=<your token> --server=<your server>
oc new-build --name=demo-express --strategy=docker --code=<github repo>
oc new-app demo-express:latest
oc expose service/demo-express
```

#### OC Command line: use yaml files
``` bash
oc login --token=<your token> --server=<your server>
oc get imagestreams
oc create imagestream demo-express
oc get buildconfigs
oc apply -f 1-buildconfig.yaml
oc apply -f 2-deployment.yaml
oc apply -f 3-service.yaml
oc apply -f 4-route.yaml
```

#### Additional OC commands

##### re-run build:
 `oc start-build demo-express`

##### add trigger to re-deploy:
  `oc set triggers deploy/demo-express --from-image=demo-express:latest -c demo-express`
