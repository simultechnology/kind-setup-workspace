#!/bin/sh
set -o errexit

# create registry container unless it already exists
reg_name='host.docker.internal'
reg_port='55000'
running="$(docker inspect -f '{{.State.Running}}' "${reg_name}" 2>/dev/null || true)"
if [ "${running}" != 'true' ]; then
  docker run \
    -e REGISTRY_HTTP_ADDR="0.0.0.0:${reg_port}" \
    -d --restart=always -p "${reg_port}:${reg_port}" --name "${reg_name}" \
    registry:2
fi

# create a cluster with the local registry enabled in containerd
cat <<EOF | kind create cluster --image kindest/node:v1.25.0 --name=$1 --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
containerdConfigPatches:
- |-
  [plugins."io.containerd.grpc.v1.cri".registry.mirrors."${reg_name}:${reg_port}"]
    endpoint = ["http://${reg_name}:${reg_port}"]
  [plugins."io.containerd.grpc.v1.cri".registry.configs."ghcr.io".tls]
    insecure_skip_verify = true
networking:
  ipFamily: ipv6
  apiServerAddress: 127.0.0.1
nodes:
  - role: control-plane
  - role: worker
  - role: worker
  - role: worker
EOF

set +e
# connect the registry to the cluster network
docker network connect "kind" "${reg_name}"
set -e

# tell https://tilt.dev to use the registry
# https://docs.tilt.dev/choosing_clusters.html#discovering-the-registry
for node in $(kind get nodes); do
  kubectl annotate node "${node}" "kind.x-k8s.io/registry=localhost:${reg_port}";
done
