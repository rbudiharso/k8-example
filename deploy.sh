#!/bin/bash

cd $(dirname $0)

kubectl create secret generic hello-node-env \
    --save-config=true \
    --from-file=env \
    --dry-run -o yaml \
    | kubectl apply -f -

checksum=md5sum
if [[ "$OSTYPE" == "darwin"* ]]; then
  checksum=md5
fi
export PATH=/usr/local/opt/gettext/bin:$PATH
export CONFIG_HASH=$(find . -type f | sort | xargs $checksum | $checksum | cut -d' ' -f 1)
export CONFIG_HASH=$CONFIG_HASH$(date +'%s')

envsubst '${CONFIG_HASH}' < deployment.yml \
    | kubectl apply -f -
