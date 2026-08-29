#!/usr/bin/env bash
set -euo pipefail

section() {
  printf '\n## %s\n' "$1"
}

safe_run() {
  local label="$1"
  shift
  printf '%s\n' "### $label"
  if ! "$@" 2>&1; then
    printf 'check_status=unavailable\n'
  fi
}

section provenance
printf 'collected_at_utc=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
printf 'collector=collect-linux-baseline.sh\n'
target_alias="$(printf '%s' "${TARGET_ALIAS:-homelab-host}" | tr -cd '[:alnum:]_.-')"
printf 'target_alias=%s\n' "${target_alias:-homelab-host}"

section host
safe_run os_release awk -F= '/^(PRETTY_NAME|VERSION_ID)=/{print}' /etc/os-release
safe_run kernel uname -srmo
safe_run uptime uptime -p

section capacity
safe_run memory free -h
safe_run block_devices lsblk -o NAME,SIZE,MODEL,FSTYPE,TYPE
safe_run filesystems df -hT / /boot /boot/firmware /srv /opt

section systemd
safe_run failed_units systemctl --failed --no-legend --no-pager

section listeners
if command -v ss >/dev/null 2>&1; then
  printf '%s\n' '### listening_ports'
  ss -lntuH | awk '{print $1, $5}' \
    | sed -E 's/([0-9]{1,3}\.){3}[0-9]{1,3}/<ip>/g; s/\[[0-9a-fA-F:]+\]/[<ipv6>]/g' \
    | sort -u
else
  printf '%s\n' '### listening_ports' 'check_status=unavailable'
fi

section runtime
if command -v docker >/dev/null 2>&1; then
  safe_run docker_version docker version --format 'server={{.Server.Version}}'
  safe_run containers docker ps --format '{{.Names}}|{{.Image}}|{{.Status}}|{{.Ports}}'
else
  printf 'docker=absent\n'
fi

section raspberry_pi
if command -v vcgencmd >/dev/null 2>&1; then
  safe_run temperature vcgencmd measure_temp
  safe_run throttling vcgencmd get_throttled
else
  printf 'vcgencmd=absent\n'
fi

section limitations
printf '%s\n' \
  'No secret values, unique IDs, serials, MAC addresses, or file contents were intentionally collected.' \
  'Storage media health and backup restorability require separate tooling and evidence.'
