#!/usr/bin/env python3
"""Build a deterministic plugin archive and checksum manifest."""

from __future__ import annotations

import argparse
import hashlib
import json
import pathlib
import stat
import zipfile


ROOT = pathlib.Path(__file__).resolve().parents[1]
PLUGIN = ROOT / "plugins" / "shadowsduck-homelab"
MANIFEST = PLUGIN / ".codex-plugin" / "plugin.json"


parser = argparse.ArgumentParser()
parser.add_argument("--output", type=pathlib.Path, default=ROOT / "dist")
parser.add_argument("--version")
args = parser.parse_args()

manifest = json.loads(MANIFEST.read_text(encoding="utf-8"))
name = manifest["name"]
version = manifest["version"]
if args.version and args.version != version:
    raise SystemExit(f"tag version {args.version} does not match plugin version {version}")

output = args.output.resolve()
output.mkdir(parents=True, exist_ok=True)
archive = output / f"{name}-{version}.zip"

with zipfile.ZipFile(archive, "w", compression=zipfile.ZIP_DEFLATED, compresslevel=9) as bundle:
    for path in sorted(PLUGIN.rglob("*")):
        if not path.is_file() or "__pycache__" in path.parts or path.suffix == ".pyc":
            continue
        relative = pathlib.Path(name) / path.relative_to(PLUGIN)
        info = zipfile.ZipInfo(relative.as_posix(), date_time=(1980, 1, 1, 0, 0, 0))
        executable = bool(path.stat().st_mode & stat.S_IXUSR)
        info.external_attr = ((0o755 if executable else 0o644) & 0xFFFF) << 16
        info.compress_type = zipfile.ZIP_DEFLATED
        bundle.writestr(info, path.read_bytes())

digest = hashlib.sha256(archive.read_bytes()).hexdigest()
checksums = output / "SHA256SUMS"
checksums.write_text(f"{digest}  {archive.name}\n", encoding="utf-8")
print(archive)
print(checksums)
