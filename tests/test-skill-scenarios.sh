#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
scenario_root="$repo_root/tests/scenarios"

fail() {
  printf 'Scenario contract failed: %s\n' "$*" >&2
  exit 1
}

declare -A scenarios=(
  [audit-homelab-host]="audit-fresh-host.md"
  [plan-homelab-bootstrap]="plan-fresh-host-bootstrap.md"
  [review-homelab-change]="review-unsafe-service-upgrade.md"
  [sync-homelab-docs]="sync-drifted-docs.md"
)

for skill in "${!scenarios[@]}"; do
  skill_file="$repo_root/plugins/shadowsduck-homelab/skills/$skill/SKILL.md"
  scenario_file="$scenario_root/${scenarios[$skill]}"
  [[ -f "$skill_file" ]] || fail "missing skill $skill"
  [[ -f "$scenario_file" ]] || fail "missing scenario for $skill"
  grep -Fqx "Skill: \`$skill\`" "$scenario_file" || fail "wrong scenario mapping for $skill"
  for heading in '## Input' '## Expected handling' '## Required output' '## Prohibited behavior'; do
    grep -Fqx "$heading" "$scenario_file" || fail "$skill lacks $heading"
  done
done

scenario_count="$(find "$scenario_root" -maxdepth 1 -type f -name '*.md' | wc -l)"
[[ "$scenario_count" -eq "${#scenarios[@]}" ]] || fail "unexpected scenario count"

if rg -n 'BEGIN [A-Z ]*PRIVATE KEY|([0-9]{1,3}\.){3}[0-9]{1,3}|([0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2}' "$scenario_root"; then
  fail "scenario contains sensitive-looking data"
fi

printf 'Skill scenario contracts: OK\n'
