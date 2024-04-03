# demo-openshify-express

Minimal Node Express example of Docker image that can be built locally or by GitHub Actions on OpenShift. Can be used as a starting point for an express application.  Rebuilds image and redeploys on push

### Build & Run Container Image on localhost: Local

* build image: `podman build -t demo-express -f Dockerfile`
* run as container: `podman run --name demo --rm -d -p 8080:8080 demo-express`

#### Verify Running Container
`http://<server address>:8080/demo-express`

`http://localhost:8080/demo-express`


### OpenShift
See README in `openshift` dir