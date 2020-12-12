# ImageHost kubernetes deployment guide



## Prerequisite
Fetch RabbitMQ erlang cookie
```bash
$ docker run -d --rm --name rabbit-cookie rabbitmq:3.8-management
$ echo -n $(docker exec rabbit-cookie cat /var/lib/rabbitmq/.erlang.cookie) | base64
# VEZQWllJR01HR1JZSVVSQ1hQTlA=
$ docker stop rabbit-cookie
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

```bash
$ kubectl apply -f ./kubernetes/rabbit
$ kubectl apply -f ./kubernetes/likes
```


## Deploy in Azure
TBD ...