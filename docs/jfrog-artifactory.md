# Creating JFrog artifactory

```bash
kubectl create ns ame
helm repo add jfrog https://charts.jfrog.io/
helm install -name artifactory jfrog/artifactory
```

[https://www.jfrog.com/confluence/display/JFROG/QuickStart+Guide%3A+Maven+and+Gradle](https://www.jfrog.com/confluence/display/JFROG/QuickStart+Guide%3A+Maven+and+Gradle)
