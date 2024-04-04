#! /bin/bash
# Deploy and expose app
#
DIR=`dirname $0`

oc apply -f $DIR/2-deployment.yaml
sleep 2
oc apply -f $DIR/3-service.yaml
sleep 2
oc apply -f $DIR/4-route.yaml