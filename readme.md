# ImageHost kubernetes deployment guide

![Configuration validator](https://github.com/MSDO-ImageHost/Deployment/workflows/Configuration%20validator/badge.svg)

Fetch RabbitMQ erlang cookie
```bash
$ /bin/bash -c ./scripts/bake-rabbit-cookie.sh
```

## Prerequisite
- [Minikube installed](https://minikube.sigs.k8s.io/docs/start/)

- [Helm installed](https://helm.sh/docs/intro/install/)


- Install mySQL operator and mongoDB (Helm v3)
```bash
$ helm repo add presslabs https://presslabs.github.io/charts
$ helm install mysql-operator presslabs/mysql-operator

$ helm repo add bitnami https://charts.bitnami.com/bitnami
$ helm install mongo-db -f ./helm-configs/mongodb_config.yaml bitnami/mongodb
```
- Install mySQL operator and mongoDB (Helm v2)
```bash
$ helm repo add presslabs https://presslabs.github.io/charts
$ helm install presslabs/mysql-operator --name mysql-operator

$ helm repo add bitnami https://charts.bitnami.com/bitnami
$ helm install -f ./helm-configs/mongodb_config.yaml bitnami/mongodb --name mongo-db
```
- Install Prometheus and Grafana for monitoring
```bash
$ helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
$ helm install prometheus prometheus-community/prometheus

$ helm repo add grafana https://grafana.github.io/helm-charts
$ helm install grafana -f ./helm-configs/grafana_config.yaml grafana/grafana
```

## Deploy in minikube

Start minikube
```bash
$ minikube start
// OR
$ /bin/bash -c ./scripts/start-minikube.sh

```

Apply k8s configurations
```bash
$ kubectl apply -f ./kubernetes
```

Wait for everything to restart and connect

Open webpage to access the React app
```bash
$ minikube service webgateway
```

## Start monitoring
Getting access to Grafana
```bash
$ kubectl expose service grafana --type=NodePort --target-port=3000 --name=grafana-np
$ minikube service grafana-np
```
For sign in on Grafana GUI use:   
- user: admin   
- password: ImageHost

Find the dashboard under Search -> Kubernetes Cluster



## Optional
Forward RabbitMQ managment UI
```bash
$ kubectl port-forward rabbitmq-0 8080:15672
```
Open http://localhost:8080


Authenticate minikube (`default` namespace) with Dockerhub
```bash
$ /bin/bash -c ./scripts/authenticate-dockerhub.sh
```
