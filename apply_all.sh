#!/bin/bash

dirs=("00-namespace" "01-zookeeper" "02-kafka" "03-yahoo-kafka-manager" "04-kafka-monitor" "05-mirrormaker" "06-proxy" "07-n8n" "08-grafana" "09-browserless")

for dir in "${dirs[@]}"; do
    kubectl apply -R -f "$dir"
done
