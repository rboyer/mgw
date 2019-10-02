#!/bin/bash

set -euo pipefail

cd "$(dirname "$0")"

if [[ $# -lt 1 ]]; then
    echo "Missing required dc arg" >&2
    exit 1
fi
datacenter=$1
shift

case "$datacenter" in
    dc1)
        ip="10.40.1.11"
        ;;
    dc2)
        ip="10.40.2.11"
        ;;
    *)
        echo "unknown dc: ${datacenter}" >&2
        exit 1
        ;;
esac

if [[ $# -lt 1 ]]; then
    echo "missing required path portion" >&2
    exit 1
fi

path="$1"
shift

exec curl -sL "http://${ip}:8500/${path}" "$@"
