# Kubernetes Deployment Guide

This guide outlines the steps to deploy a Spring Boot application on Kubernetes using kubectl command.

## Prerequisites
- Docker installed and running
- Minikube installed
- Kubernetes CLI (`kubectl`) installed

## Step 1: Build Docker Image
```sh
docker build -t springboot-k8s:1.0 .
```
This command builds the Docker image for the Spring Boot application with the tag `springboot-k8s:1.0`.

### Verify the Docker Image
```sh
docker images
```
#### Sample Output:
```
REPOSITORY       TAG       IMAGE ID       CREATED          SIZE
springboot-k8s   1.0       05b6d83e94df   11 minutes ago   539MB
```

## Step 2: Start Minikube
```sh
minikube start
```
This starts a Minikube cluster.

## Step 3: Use Minikube Docker Daemon
```sh
eval $(minikube -p minikube docker-env)
```
This configures the terminal to use the Docker daemon inside Minikube.

## Step 4: Deploy the Application
```sh
kubectl create deployment springboot-k8s --image=springboot-k8s:1.0 --port=9090
```
This creates a Kubernetes deployment named `springboot-k8s`.

### Verify Deployment
```sh
kubectl get deployments
```
#### Sample Output:
```
NAME             READY   UP-TO-DATE   AVAILABLE   AGE
springboot-k8s   1/1     1            1           3m
```

## Step 5: Check Deployment Details
```sh
kubectl describe deployment springboot-k8s
```
This displays detailed information about the deployment.

## Step 6: View Running Pods
```sh
kubectl get pods
```
#### Sample Output:
```
NAME                              READY   STATUS    RESTARTS   AGE
springboot-k8s-556bf85969-pbfgx   1/1     Running   0          2m5s
```

## Step 7: Check Application Logs
```sh
kubectl logs <pod-name>
```
Example:
```sh
kubectl logs springboot-k8s-556bf85969-pbfgx
```

## Step 8: Expose Deployment as a Service
```sh
kubectl expose deployment springboot-k8s --type=NodePort
```
This exposes the deployment as a **NodePort** service.

### Verify Service
```sh
kubectl get services
```
#### Sample Output:
```
NAME             TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
springboot-k8s   NodePort    10.98.48.113    <none>        9090:32252/TCP   4s
```

### OR

## Step 8: Deploy Using YAML Configuration 
Instead of manually running commands, you can define your deployment and service in YAML files and apply them.

### Apply the YAML Configurations
```sh
kubectl apply -f k8s-deployment.yaml
kubectl apply -f k8s-service.yaml
```
#### Sample Output:
```sh
service/springboot-k8s-service created
```

#### Verify the Deployment and Service
```sh
kubectl get svc
```
#### Sample Output:
```
NAME                     TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
details                  ClusterIP   10.109.5.103     <none>        9080/TCP         27h
kubernetes               ClusterIP   10.96.0.1        <none>        443/TCP          33d
productpage              ClusterIP   10.97.187.183    <none>        9080/TCP         27h
ratings                  ClusterIP   10.101.184.156   <none>        9080/TCP         27h
reviews                  ClusterIP   10.100.114.113   <none>        9080/TCP         27h
springboot-k8s           NodePort    10.98.48.113     <none>        9090:32252/TCP   135m
springboot-k8s-service   NodePort    10.109.115.147   <none>        9090:32615/TCP   26s
```

## Step 9: Access the Application
```sh
minikube service springboot-k8s --url
```

### OR

```sh
minikube service springboot-k8s-service --url
```
#### Sample Output:
```
http://127.0.0.1:56794
```

### OR

```
http://127.0.0.1:59747
```
Open this URL in a browser to access the application.

## Step 12: Open Kubernetes Dashboard
```sh
minikube dashboard
```
This launches the Kubernetes dashboard in a web browser.