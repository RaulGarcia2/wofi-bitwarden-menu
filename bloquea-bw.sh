#!/bin/bash
HOST='rpi5c:9090'

MINUTOS=$1
SEGUNDOS=$((MINUTOS * 60))
#
#date +%s > /tmp/bw_raul
sleep $SEGUNDOS

curl -X POST http://${HOST}/lock

