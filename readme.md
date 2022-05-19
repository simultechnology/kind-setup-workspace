# Setup k8s environment

## Prerequisite

install kind

https://kind.sigs.k8s.io/docs/user/quick-start/#installation

## create ipv6 cluster
```
sh assets/kind/kind-v6-with-registry.sh ipv6-cluster
```

## create ipv4 cluster
```
sh assets/kind/kind-v4-with-registry.sh ipv4-cluster
```
