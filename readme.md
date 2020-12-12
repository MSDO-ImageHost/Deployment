# ImageHost kubernetes deployment guide



## Prerequisite
Fetch RabbitMQ erlang cookie
```bash
$ /bin/bash -c bake-rabbit-cookie.sh
```

Set RabbitMQ mirroring policy
```bash
$ kubectl exec -it rabbitmq-0 bash
$ rabbitmqctl set_policy ha-fed \
    ".*" '{"federation-upstream-set":"all", "ha-sync-mode":"automatic", "ha-mode":"nodes", "ha-params":["rabbit@rabbitmq-0.rabbitmq.default.svc.cluster.local","rabbit@rabbitmq-1.rabbitmq.default.svc.cluster.local","rabbit@rabbitmq-2.rabbitmq.default.svc.cluster.local"]}' \
    --priority 1 \
    --apply-to queues
```

Forward RabbitMQ managment UI
```bash
$ kubectl port-forward rabbitmq-0 8080:15672
```
Open http://localhost:8080

## Deploy in minikube

Start minikube
```bash
$ minicube start
$ minikube addons enable ingress
```
Apply k8s configurations
```bash
$ kubectl apply -f ./kubernetes-flattened
```
Wait for everything to start up
```bash
$ minikube service webgateway --url
// http://192.168.49.2:31065
```

## Deploy in Azure
TBD ...