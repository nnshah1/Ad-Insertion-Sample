#!/bin/bash

DIR=$(dirname $(readlink -f "$0"))

# delete all pods, services and deployments
for yaml in $(find "${DIR}" -maxdepth 1 -name "*.yaml" -print); do
    kubectl delete --wait=false -f "$yaml" --ignore-not-found=true 2>/dev/null
done

kubectl delete secret self-signed-certificate 2> /dev/null || echo -n ""
