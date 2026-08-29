#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
plugin_root="$repo_root/plugins/shadowsduck-homelab"
skill_validator="${SKILL_VALIDATOR:-$HOME/.codex/skills/.system/skill-creator/scripts/quick_validate.py}"
plugin_validator="${PLUGIN_VALIDATOR:-$HOME/.codex/skills/.system/plugin-creator/scripts/validate_plugin.py}"

fail() {
  printf 'ERROR: %s\n' "$*" >&2
  exit 1
}

[[ -f "$skill_validator" ]] || fail "Skill validator not found: $skill_validator"
[[ -f "$plugin_validator" ]] || fail "Plugin validator not found: $plugin_validator"

python3 "$repo_root/scripts/validate_portable.py"

while IFS= read -r skill_dir; do
  python3 "$skill_validator" "$skill_dir"
done < <(find "$plugin_root/skills" -mindepth 1 -maxdepth 1 -type d | sort)

python3 "$plugin_validator" "$plugin_root"

if rg -n '\[TODO:|TODO\b|FIXME\b' "$repo_root" \
  --glob '!scripts/validate.sh' \
  --glob '!scripts/validate_portable.py' \
  --glob '!.github/workflows/validate.yml' \
  --glob '!.git/**'; then
  fail "Placeholder text remains"
fi

while IFS= read -r script; do
  bash -n "$script"
done < <(find "$repo_root" -type f -name '*.sh' ! -path '*/.git/*' | sort)

while IFS= read -r test_script; do
  "$test_script"
done < <(find "$repo_root/tests" -type f -name 'test-*.sh' | sort)

python3 - "$repo_root" <<'PY'
import json
import pathlib
import sys

root = pathlib.Path(sys.argv[1])
marketplace = json.loads((root / ".agents/plugins/marketplace.json").read_text())
for entry in marketplace["plugins"]:
    plugin = root / "plugins" / entry["name"]
    manifest = json.loads((plugin / ".codex-plugin/plugin.json").read_text())
    if manifest["name"] != entry["name"]:
        raise SystemExit(f"Plugin name mismatch: {entry['name']}")
print("Marketplace consistency: OK")
PY

printf 'Repository validation: OK\n'
