#!/usr/bin/env bash



TARGET="$1"
START_PORT="${2:-1}"
END_PORT="${3:-1024}"
TIMEOUT=1

if [[ -z "$TARGET" ]]; then
    echo "Usage : $0 <ip|hostname> [port_debut] [port_fin]"
    exit 1
fi

echo "=================================="
echo " Scan de $TARGET"
echo " Ports : $START_PORT -> $END_PORT"
echo "=================================="

open_ports=0

for ((port=START_PORT; port<=END_PORT; port++)); do
    timeout "$TIMEOUT" bash -c "echo >/dev/tcp/$TARGET/$port" 2>/dev/null

    if [[ $? -eq 0 ]]; then
        printf "[OPEN ] %5d\n" "$port"
        ((open_ports++))
    fi
done

echo
echo "Scan finished"

if [[ $open_ports -eq 0 ]]; then
    echo "no port opened"
else
    echo "$open_ports ports ouverts"
fi
