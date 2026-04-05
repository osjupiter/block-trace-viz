#!/bin/bash
set -eu

VM_DIR="$(cd "$(dirname "$0")" && pwd)"
SSH_PORT=2222
USER=dev
HOST=localhost

ssh -o StrictHostKeyChecking=no \
    -o UserKnownHostsFile=/dev/null \
    -i "${VM_DIR}/id_ed25519" \
    -p "${SSH_PORT}" \
    "${USER}@${HOST}" \
    "$@"
