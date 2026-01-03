#!/bin/bash

PROCESO="${HOME}/.local/bin/bloquea-bw.sh"

PID=$(pgrep -u ${UID} -f "$PROCESO")

if [ -n "$PID" ]; then
    echo "Procesos encontrado con PID(s): $PID"
    echo "Matando procesos..."
    for i in ${PID};
    do
        PGID=$(ps -p ${i} -o pgid --no-headers)
        x=$((PGID))
        kill -TERM -${x}
        echo "Matado ${x}"
    done
else
    echo "El proceso $PROCESS_NAME no se está ejecutando."
fi
