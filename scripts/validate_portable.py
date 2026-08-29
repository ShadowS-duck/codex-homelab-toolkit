#!/usr/bin/env python3
"""Validate repository contracts using only the Python standard library."""

from __future__ import annotations

import json
import pathlib
import re
import sys


ROOT = pathlib.Path(__file__).resolve().parents[1]
PLUGIN = ROOT / "plugins" / "shadowsduck-homelab"
NAME_RE = re.compile(r"^[a-z0-9]+(?:-[a-z0-9]+)*$")
SEMVER_RE = re.compile(r"^\d+\.\d+\.\d+(?:-[0-9A-Za-z.-]+)?(?:\+[0-9A-Za-z.-]+)?$")


def fail(message: str) -> None:
    raise SystemExit(f"ERROR: {message}")


def load_json(path: pathlib.Path) -> dict:
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as exc:
        fail(f"invalid JSON at {path.relative_to(ROOT)}: {exc}")


def parse_skill(path: pathlib.Path) -> tuple[str, str]:
    text = path.read_text(encoding="utf-8")
    match = re.match(
        r"\A---\nname: ([^\n]+)\ndescription: ([^\n]+)\n---\n",
        text,
    )
    if not match:
        fail(f"invalid skill frontmatter: {path.relative_to(ROOT)}")
    return match.group(1).strip(), match.group(2).strip()


manifest = load_json(PLUGIN / ".codex-plugin" / "plugin.json")
if manifest.get("name") != PLUGIN.name:
    fail("plugin folder and manifest name differ")
if not SEMVER_RE.fullmatch(str(manifest.get("version", ""))):
    fail("plugin version is not strict semantic versioning")
for required in ("description", "author", "skills", "interface"):
    if not manifest.get(required):
        fail(f"plugin field is missing: {required}")

skill_names: set[str] = set()
for skill_dir in sorted((PLUGIN / "skills").iterdir()):
    if not skill_dir.is_dir():
        continue
    name, description = parse_skill(skill_dir / "SKILL.md")
    if name != skill_dir.name or not NAME_RE.fullmatch(name) or len(name) > 64:
        fail(f"invalid skill name: {name}")
    if len(description) < 40:
        fail(f"skill description is too short: {name}")
    metadata = (skill_dir / "agents" / "openai.yaml").read_text(encoding="utf-8")
    for field in ("display_name:", "short_description:", "default_prompt:"):
        if field not in metadata:
            fail(f"{name} metadata is missing {field}")
    if f"${name}" not in metadata:
        fail(f"{name} default prompt does not invoke the skill")
    skill_names.add(name)

if not skill_names:
    fail("plugin contains no skills")

marketplace = load_json(ROOT / ".agents" / "plugins" / "marketplace.json")
entries = marketplace.get("plugins", [])
matches = [entry for entry in entries if entry.get("name") == PLUGIN.name]
if len(matches) != 1:
    fail("marketplace must contain exactly one matching plugin entry")
entry = matches[0]
if entry.get("policy", {}).get("installation") not in {
    "NOT_AVAILABLE",
    "AVAILABLE",
    "INSTALLED_BY_DEFAULT",
}:
    fail("invalid marketplace installation policy")
if entry.get("policy", {}).get("authentication") not in {"ON_INSTALL", "ON_USE"}:
    fail("invalid marketplace authentication policy")
if not entry.get("category"):
    fail("marketplace category is missing")

for path in ROOT.rglob("*"):
    if not path.is_file() or ".git" in path.parts or path.name in {
        "validate_portable.py",
        "validate.sh",
        "validate.yml",
    }:
        continue
    if path.suffix.lower() not in {".md", ".json", ".yaml", ".yml", ".sh"}:
        continue
    text = path.read_text(encoding="utf-8", errors="replace")
    if re.search(r"\[TODO:|\bTODO\b|\bFIXME\b", text):
        fail(f"placeholder remains in {path.relative_to(ROOT)}")

print("Portable repository validation: OK")
