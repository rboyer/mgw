#!/bin/bash

set -euo pipefail

cd "$(dirname "$0")"

if ! command -v consul >/dev/null 2>&1 ; then
    echo "ERROR: no 'consul' binary on PATH. Please run 'make dev' from your consul checkout" >&2
    exit 1
fi

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

export CONSUL_HTTP_ADDR="http://${ip}:8500"

exec consul "$@"
