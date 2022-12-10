# Dashboards

you can use kubeapps

[https://github.com/vmware-tanzu/kubeapps/blob/main/site/content/docs/latest/tutorials/getting-started.md](https://github.com/vmware-tanzu/kubeapps/blob/main/site/content/docs/latest/tutorials/getting-started.md)

- install Kubeapps

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
kubectl create namespace kubeapps
helm install kubeapps --namespace kubeapps bitnami/kubeapps
```

- Create a demo credential with which to access Kubeapps and Kubernetes

```bash
kubectl create --namespace default serviceaccount kubeapps-operator
kubectl create clusterrolebinding kubeapps-operator --clusterrole=cluster-admin --serviceaccount=default:kubeapps-operator
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: kubeapps-operator-token
  namespace: default
  annotations:
    kubernetes.io/service-account.name: kubeapps-operator
type: kubernetes.io/service-account-token
EOF
```

get the token required to log in this App from browser

```bash
kubectl get --namespace default secret kubeapps-operator-token -o go-template='{{.data.token | base64decode}}'
```

to access from your local environment, you can use port-forward

```bash
kubectl port-forward -n kubeapps svc/kubeapps 8080:80
```
