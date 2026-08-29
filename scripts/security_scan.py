#!/usr/bin/env python3
"""Fail on high-confidence secret material and unsafe tracked artifacts."""

from __future__ import annotations

import pathlib
import re
import subprocess


ROOT = pathlib.Path(__file__).resolve().parents[1]
MAX_TRACKED_SIZE = 1_048_576
BLOCKED_SUFFIXES = {".key", ".p12", ".pem", ".pfx", ".pyc", ".pyo"}
BLOCKED_NAMES = {".env", "id_dsa", "id_ecdsa", "id_ed25519", "id_rsa"}
SECRET_PATTERNS = {
    "private key": re.compile(r"-----BEGIN [A-Z0-9 ]*PRIVATE KEY-----"),
    "GitHub token": re.compile(r"(?:gh[pousr]_[A-Za-z0-9]{36,}|github_pat_[A-Za-z0-9_]{40,})"),
    "AWS access key": re.compile(r"AKIA[0-9A-Z]{16}"),
    "Slack token": re.compile(r"xox[baprs]-[A-Za-z0-9-]{20,}"),
}


def fail(message: str) -> None:
    raise SystemExit(f"ERROR: {message}")


tracked_output = subprocess.run(
    ["git", "ls-files", "-z"],
    cwd=ROOT,
    check=True,
    stdout=subprocess.PIPE,
).stdout

for raw_path in tracked_output.split(b"\0"):
    if not raw_path:
        continue
    relative = pathlib.Path(raw_path.decode("utf-8"))
    path = ROOT / relative
    lowered_parts = {part.lower() for part in relative.parts}
    if relative.suffix.lower() in BLOCKED_SUFFIXES or relative.name.lower() in BLOCKED_NAMES:
        fail(f"blocked tracked artifact: {relative}")
    if "__pycache__" in lowered_parts or "secrets" in lowered_parts:
        fail(f"blocked tracked path: {relative}")
    if path.is_symlink():
        fail(f"tracked symlink requires explicit review: {relative}")
    if path.stat().st_size > MAX_TRACKED_SIZE:
        fail(f"tracked file exceeds 1 MiB: {relative}")
    text = path.read_text(encoding="utf-8", errors="ignore")
    for label, pattern in SECRET_PATTERNS.items():
        if pattern.search(text):
            fail(f"possible {label} in {relative}")

print("Repository security scan: OK")
