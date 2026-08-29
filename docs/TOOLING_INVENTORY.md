# Tooling Inventory

Inventory date: 2026-08-29

This inventory separates owner-authored tooling from Codex-managed runtime
components. It records names and design characteristics only; it does not copy
credentials, host details, or private configuration.

## Owner-authored tooling

| Component | Source | State | Decision |
| --- | --- | --- | --- |
| `shadowsduck-homelab` | Public `shadowsduck` marketplace | Installed, enabled, version 0.1.0 | Canonical toolkit plugin |
| `raspberry-control` | Local `personal` marketplace | Installed, enabled, version 0.1.0 | Legacy; keep separate until replaced |

No standalone owner-authored skills were found outside these plugins.

## Codex-managed tooling

System skills and plugins supplied by Codex or installed from OpenAI-managed
marketplaces are runtime dependencies, not project source. Do not vendor or
republish them from this repository. Their versions and availability can change
with the application runtime.

The toolkit may rely on documented Codex interfaces, but every release must be
validated against the installed runtime rather than assuming managed files are
stable.

## Legacy plugin finding

The legacy `raspberry-control` plugin keeps authentication outside its source by
using an owner-managed SSH alias. That is a useful boundary. Its general-purpose
execution tool, however, accepts an arbitrary remote shell command, while its
health command contains a fixed list of services from an older installation.
It also lacks repository tests, a release process, and an explicit audit record.

The plugin is therefore not copied into the public toolkit. See
[Legacy Raspberry Control Migration](LEGACY_RASPBERRY_CONTROL.md) for the
replacement criteria.

## Inventory policy

- Record owner-authored tools before migration.
- Never copy generated caches, bytecode, tokens, keys, host addresses, or raw
  operational output.
- Treat managed Codex components as dependencies, not owned artifacts.
- Migrate behavior only after defining scope, authorization, sanitization,
  rollback, and tests.
- Remove a legacy component only after its replacement is installed and its
  bounded workflows have been verified.
