#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
collector="$repo_root/plugins/shadowsduck-homelab/skills/audit-homelab-host/scripts/collect-linux-baseline.sh"
output="$(TARGET_ALIAS='test-host' "$collector" 2>&1)"

grep -q '^target_alias=test-host$' <<<"$output"
grep -q '^collector=collect-linux-baseline.sh$' <<<"$output"
grep -q '^## limitations$' <<<"$output"

if grep -Eq '/home/|BEGIN [A-Z ]*PRIVATE KEY|([0-9]{1,3}\.){3}[0-9]{1,3}|([0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2}' <<<"$output"; then
  printf 'Collector emitted a sensitive-looking value\n' >&2
  exit 1
fi

printf 'Collector test: OK\n'
