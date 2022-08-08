#!/bin/bash
if ! kubectl get ns mohamed-bassiouni; then
    kubectl create ns mohamed-bassiouni
fi

if ! kubectl rollout status deployment sample-spring-boot -n matthew-oberlies; then
    kubectl apply -f kubernetes.yml
fi