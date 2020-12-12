#!/bin/bash

RABBIT=$(docker run -d --rm rabbitmq:3.8-management)
sleep 3
COOKIE=$(docker exec $RABBIT cat /var/lib/rabbitmq/.erlang.cookie)
docker stop $RABBIT>/dev/null
echo BASE64 COOKIE: $(echo -n $COOKIE | base64)