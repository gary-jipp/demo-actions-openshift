# demo-openshify-express

Minimal Node Express example of Docker image that can be built locally or by GitHub Actions on OpenShift. Can be used as a starting point for an express application.  Rebuilds image and redeploys on push

### Build & Run Container Image on localhost: Local

* build image: `podman build -t demo-express -f Dockerfile`
* run as container: `podman run --name demo --rm -d -p 8080:8080 demo-express`

#### Verify Running Container
`http://<server address>:8080/demo-express`

`http://localhost:8080/demo-express`


### Build & Run Container Image: Openshift

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
