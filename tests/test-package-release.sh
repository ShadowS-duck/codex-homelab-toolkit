#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
release_tmp="$(mktemp -d)"
second_tmp="$(mktemp -d)"
trap 'rm -rf -- "$release_tmp" "$second_tmp"' EXIT

python3 "$repo_root/scripts/package_release.py" --version 0.1.0 --output "$release_tmp" >/dev/null
python3 "$repo_root/scripts/package_release.py" --version 0.1.0 --output "$second_tmp" >/dev/null

archive="$release_tmp/shadowsduck-homelab-0.1.0.zip"
[[ -s "$archive" ]]
[[ -s "$release_tmp/SHA256SUMS" ]]
cmp -s "$archive" "$second_tmp/shadowsduck-homelab-0.1.0.zip"

python3 -m zipfile -l "$archive" | grep -Fq 'shadowsduck-homelab/.codex-plugin/plugin.json'
for skill in audit-homelab-host plan-homelab-bootstrap review-homelab-change sync-homelab-docs; do
  python3 -m zipfile -l "$archive" | grep -Fq "shadowsduck-homelab/skills/$skill/SKILL.md"
done

(cd "$release_tmp" && sha256sum -c SHA256SUMS >/dev/null)
printf 'Release package test: OK\n'
