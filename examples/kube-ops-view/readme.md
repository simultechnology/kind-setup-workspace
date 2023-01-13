
# show kube-ops-view

## deploy

```bash
git clone git@github.com:hjacobs/kube-ops-view.git
kubectl apply -k kube-ops-view/deploy
```

## see the screen on your local machine

```bash
kubectl port-forward svc/kube-ops-view 18180:80 &
```

you can see the screen by this ip address

[http://localhost:18180/](http://localhost:18180/)

