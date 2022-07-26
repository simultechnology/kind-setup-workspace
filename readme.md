# Setup k8s environment

## Prerequisite

### install Docker Desktop

[https://www.docker.com/products/docker-desktop/](https://www.docker.com/products/docker-desktop/)

### install kind

[https://kind.sigs.k8s.io/docs/user/quick-start/#installation](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)

## create ipv6 cluster

```bash
make setup-v6
```

## create ipv4 cluster

```bash
make setup-v4
```

## delete ipv6 cluster

```bash
make clean-v6
```

## delete ipv4 cluster

```bash
make clean-v4
```


