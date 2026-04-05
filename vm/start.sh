#!/bin/bash
set -eu

VM_DIR="$(cd "$(dirname "$0")" && pwd)"
MEMORY=4G
CPUS=4
SSH_PORT=2222

# 共有ディレクトリ作成
mkdir -p "${VM_DIR}/share"

LOG="${VM_DIR}/vm.log"

nohup qemu-system-x86_64 \
  -enable-kvm \
  -cpu host \
  -smp "${CPUS}" -m "${MEMORY}" \
  -drive file="${VM_DIR}/ubuntu.qcow2",if=virtio,format=qcow2 \
  -drive file="${VM_DIR}/seed.iso",if=virtio,format=raw \
  -drive file="${VM_DIR}/test-disk1.raw",if=virtio,format=raw \
  -drive file="${VM_DIR}/test-disk2.raw",if=virtio,format=raw \
  -virtfs local,path="${VM_DIR}/share",mount_tag=host0,security_model=mapped-xattr \
  -nic user,hostfwd=tcp::${SSH_PORT}-:22 \
  -serial file:"${LOG}" \
  -nographic \
  -pidfile "${VM_DIR}/vm.pid" \
  > /dev/null 2>&1 &

echo "VM started (PID $!). Log: ${LOG}"
