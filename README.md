# GPUrunner

Github runner enclosed in a container. This project allows to run multiple github runners on one machine.
By encapsulating them to a contianer, you can provision multiple runners on the same machine with different capabilities for your projects.

Runners will appear in your project and you will be able to run workflows in your github repo.

## Usage
``` bash 
#build
cd runner
make build
make run
```

Please make sure you add your variables in the makefile if you need.

# Running multiple runners: 
Adding runners can be done using docker compose or using kubernetes cluster.

```bash 
# get version of the latest runner
RUNNER_VERSION=$(curl -s https://github.com/actions/runner/tags/ | grep -Eo " v[0-9]+.[0-9]+.[0-9]+" | head -n1 | tr -d 'v ')
GH_OWNER='your-github-username'
GH_REPOSITORY='your-github-repository'
```
```yaml
services:
  runner:
    image: runner:latest
    working_dir: /app
    build:
      context: runnner/.
      dockerfile: ./runnner/Dockerfile
      args:
        - RUNNER_VERSION=${RUNNER_VERSION}
    deploy:
      replicas: 2
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    ports:
      - "3000:3000"
    environment:
      - GH_OWNER=${GH_OWNER}
      - GH_REPOSITORY=${GH_REPOSITORY} 
    command: npm start
```

Deployment in kubernetes cluster. Note that you wiull have to take care of transfering the image using a registry.
``` yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: githubRunner
  namespace: runners
spec:
  selector:
    matchLabels:
      name: runner
  template:
    metadata:
      labels:
        name: runner
    spec:
      containers:
      - name: runner1
        image: runner:latest
```