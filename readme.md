# Setup k8s environment

## Prerequisite

### install Docker Desktop

[https://www.docker.com/products/docker-desktop/](https://www.docker.com/products/docker-desktop/)

### install kind

[https://kind.sigs.k8s.io/docs/user/quick-start/#installation](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)

## Create and Delete a cluster

### create ipv6 cluster

```bash
make setup-v6
```

### create ipv4 cluster

```bash
make setup-v4
```

### delete ipv6 cluster

```bash
make clean-v6
```

### delete ipv4 cluster

```bash
make clean-v4
```

## Docker Registry

### local Docker Registry

#### see image lists

[http://127.0.0.1:5000/v2/_catalog](http://127.0.0.1:5000/v2/_catalog)

#### push a Docker image to local registry

```bash
docker tag your-image:0.0.1 127.0.0.1:5000/your-image:0.0.1

```

#### pull the image from pods in kubernetes cluster

you can access to 127.0.0.1:5000 registry on host by host.docker.internal:5000 in pods.

```bash
docker pull host.docker.internal:5000/your-image:0.0.1
```

## Samples

build docker image from Dockerfile and push it to local registry

```bash
cd samples/
docker build -t docker-for-crictl:0.0.1 . --network=host
docker tag docker-for-crictl:0.0.1 127.0.0.1:5000/docker-for-crictl:0.0.1
docker push 127.0.0.1:5000/docker-for-crictl:0.0.1

# create Daemonset on this kind cluster
kubectl apply -f sample-ds-dind.yaml
```

## Reference

### document of Kind 

[https://kind.sigs.k8s.io/docs/user/quick-start/](https://kind.sigs.k8s.io/docs/user/quick-start/)



