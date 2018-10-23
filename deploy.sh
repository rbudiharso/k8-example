#!/bin/bash

cd $(dirname $0)

kubectl create secret generic hello-node-env \
    --save-config=true \
    --from-file=env \
    --dry-run -o yaml \
    | kubectl apply -f -

export CONFIG_HASH=$(find . -type f | sort | xargs md5sum | md5sum | cut -d' ' -f 1)
export CONFIG_HASH=$CONFIG_HASH$(date +'%s')

envsubst '${CONFIG_HASH}' < deployment.yml \
    | kubectl apply -f -
