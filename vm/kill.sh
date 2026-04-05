#!/bin/bash
set -eu

VM_DIR="$(cd "$(dirname "$0")" && pwd)"
PID_FILE="${VM_DIR}/vm.pid"

if [ -f "${PID_FILE}" ]; then
  PID=$(cat "${PID_FILE}")
  if kill -0 "${PID}" 2>/dev/null; then
    kill "${PID}"
    echo "VM (PID ${PID}) stopped."
  else
    echo "VM process (PID ${PID}) not running."
  fi
  rm -f "${PID_FILE}"
else
  echo "No PID file found."
fi
