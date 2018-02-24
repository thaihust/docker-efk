#!/usr/bin/env bash

sed -i "s|ELS_HOST|${ELS_HOST}|g" /fluentd/etc/fluent.conf

while ! nc -w 1 ${ELS_HOST} 9200 > /dev/null 2>&1; do
  echo "Fluentd waiting TCP connection $ELASTICSEARCH_PORT_9200_TCP_ADDR:$ELASTICSEARCH_PORT_9200_TCP_PORT..."
  sleep 1
done

echo "Start fluentd"
fluentd -c /fluentd/etc/$FLUENTD_CONF -p /fluentd/plugins $FLUENTD_OPT
