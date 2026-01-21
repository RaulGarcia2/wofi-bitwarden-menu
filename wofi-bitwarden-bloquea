#!/bin/bash

CONFIG_FILE="${HOME}/.config/bwmenu.conf"
HOST="localhost"
PORT="9090"

if [ -f "$CONFIG_FILE" ]; then
    HOST=$(grep '^HOST=' "$CONFIG_FILE" | cut -d'=' -f2)
    PORT=$(grep '^PORT=' "$CONFIG_FILE" | cut -d'=' -f2)
fi

MINUTOS=$1
SEGUNDOS=$((MINUTOS * 60))

sleep $SEGUNDOS

curl -X POST "http://${HOST}:${PORT}/lock"

