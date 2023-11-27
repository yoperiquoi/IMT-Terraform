#!/usr/bin/env bash

DEBIAN_FRONTEND=noninteractive apt update -q
DEBIAN_FRONTEND=noninteractive apt install -q -y redis

sed -i -e 's/^bind 127.0.0.1 ::1/bind 0.0.0.0/' /etc/redis/redis.conf
sed -i -e '/# requirepass foobared/a requirepass polo' /etc/redis/redis.conf