# ImageHost kubernetes deployment guide

![Configuration validator](https://github.com/MSDO-ImageHost/Deployment/workflows/Configuration%20validator/badge.svg)

## Prerequisite
Fetch RabbitMQ erlang cookie
```bash
$ /bin/bash -c ./scripts/bake-rabbit-cookie.sh
```

[Helm installed](https://helm.sh/docs/intro/install/)


Install mySQL operator and mongoDB (Helm v3)
```bash
$ helm repo add presslabs https://presslabs.github.io/charts
$ helm install mysql-operator presslabs/mysql-operator

$ helm repo add bitnami https://charts.bitnami.com/bitnami
$ helm install mongoDB -f mongodb_config.yaml bitnami/mongodb
```
Install mySQL operator and mongoDB (Helm v2)
```bash
$ helm repo add presslabs https://presslabs.github.io/charts
$ helm install presslabs/mysql-operator --name mysql-operator

$ helm repo add bitnami https://charts.bitnami.com/bitnami
$ helm install -f mongodb_config.yaml bitnami/mongodb --name mongoDB
```

## Deploy in minikube

Start minikube
```bash
$ minicube start
$ minikube addons enable ingress
// OR
$ /bin/bash -c ./scripts/start-minikube.sh

```

Apply k8s configurations
```bash
$ kubectl apply -f ./kubernetes
```

Configure MongoDB replicaset synchronization
```bash
$ kubectl exec -it mongo-0 -- mongo
> rs.initiate()
> var cfg = rs.conf()
> cfg.members[0].host="mongo-0.mongo:27017"
> rs.reconfig(cfg)
> rs.add("mongo-1.mongo:27017")
> rs.add("mongo-2.mongo:27017")
> exit
// bye
```

Wait for everything to restart and connect

Open webpage
```bash
$ minikube service webgateway
```



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