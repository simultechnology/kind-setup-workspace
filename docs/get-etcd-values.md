# how to get values of etcd pod from local machine

## install etcd on your machine


### on root directory of this project

```
sh scripts/etcd-download.sh
```
 
### add these etcd binary files to your path

```
mv /tmp/etcd-download-test/* ~/bin/
``` 

## how to access etcd pod by etcdctl

### 1. create a secret using the kubectl tool by querying the etcd server using the etcdctl CLI

```
kubectl create secret generic db-secret \
	--from-literal=username=devuser \
	--from-literal=password=devpassword
```

### 2. specify etcd pod name 

```
kubectl get po -n kube-system| grep etcd
```

the output is below

```
etcd-ipv6-cluster-control-plane                      1/1     Running   0          2d11h
```

### 3. port forward to your local port

```
kubectl port-forward -n kube-system etcd-ipv6-cluster-control-plane 2379:2379
```

### 4. copy the etcd certificates

#### 4-1. confirm where the certificates are located

```
kubectl describe po etcd-ipv6-cluster-control-plane -n kube-system
```

the output is below

```
Name:                 etcd-ipv6-cluster-control-plane
Namespace:            kube-system
:
Containers:
  etcd:
    Container ID:  containerd://493cb6efcfbf3bdd6186b6b8322265a70e5d125d4befb6d4d957a2d1ae7ebbf3
    Image:         registry.k8s.io/etcd:3.5.4-0
    Image ID:      sha256:8e041a3b0ba8b5f930b1732f7e2ddb654b1739c89b068ff433008d633a51cd03
    Port:          <none>
    Host Port:     <none>
    Command:
      etcd
		:
      --peer-cert-file=/etc/kubernetes/pki/etcd/peer.crt
      --peer-key-file=/etc/kubernetes/pki/etcd/peer.key
:
Volumes:
  etcd-certs:
    Type:          HostPath (bare host directory volume)
    Path:          /etc/kubernetes/pki/etcd
    HostPathType:  DirectoryOrCreate
:
```

Because this volume type is HostPath, you can get peer.crt and peer.key from Host Node.

#### 4-2. get the certificates from the master node

##### 4-2-1. confirm the docker container of the master node
```
docker container ls | grep ipv6-cluster-control-plane
```

the output is below

```
1a7236c5a512   kindest/node:v1.25.2 127.0.0.1:64973->6443/tcp  ipv6-cluster-control-plane
```

##### 4-2-2. copy the certificates to your local directory

```bash
docker cp ipv6-cluster-control-plane:/etc/kubernetes/pki/etcd/peer.key /tmp/peer.key
docker cp ipv6-cluster-control-plane:/etc/kubernetes/pki/etcd/peer.crt /tmp/peer.crt

export \
  ETCDCTL_API=3 \
  ETCDCTL_INSECURE_SKIP_TLS_VERIFY=true  \
  ETCDCTL_CERT=/tmp/peer.crt \
  ETCDCTL_KEY=/tmp/peer.key
```

##### 4-2-3. etcdctl output

```
 etcdctl get /registry/secrets/default/db-secret
```

the output is below

```
/registry/secrets/default/db-secret
k8s


v1Secret�
�
	db-secretdefault"*$9abf3d53-165c-40c5-9cf4-540e444eb2da2��ќ�u
kubectl-createUpdatev��ќFieldsV1:A
?{"f:data":{".":{},"f:password":{},"f:username":{}},"f:type":{}}B
password
        devpassword
usernamedevuserOpaque"
```