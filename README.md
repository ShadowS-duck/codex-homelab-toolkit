# Codex Homelab Toolkit

Reusable Codex skills, plugins, and marketplace metadata for building and
operating homelabs safely.

This repository is the toolchain. A separate infrastructure repository consumes
the released tools and contains environment-specific desired state.

## Initial package

The `shadowsduck-homelab` plugin starts with four foundational skills:

- `audit-homelab-host` — collect a sanitized, read-only Linux baseline;
- `plan-homelab-bootstrap` — design a phased, reversible host bootstrap;
- `review-homelab-change` — assess infrastructure changes and rollback evidence;
- `sync-homelab-docs` — reconcile observed state, desired state, and documents.

See [the skill catalog](docs/SKILL_CATALOG.md) for planned capabilities and
maturity levels.

## Repository layout

```text
.
├── .agents/plugins/marketplace.json
├── .github/workflows/
├── docs/
├── plugins/
│   └── shadowsduck-homelab/
│       ├── .codex-plugin/plugin.json
│       └── skills/
├── scripts/
├── tests/
└── AGENTS.md
```

## Development

Run the repository validator:

```bash
./scripts/validate.sh
```

The validator checks skill metadata, plugin metadata, placeholder text, shell
syntax, and marketplace consistency. It does not prove safety on every host;
live testing requires a disposable or explicitly authorized environment.

## Release model

Skills begin as experimental, graduate to tested after realistic validation,
and become stable only after installation and upgrade behavior are verified.
Packaging a skill in a plugin makes it distributable; it does not automatically
make it public in a universal marketplace.

## License

MIT. See [LICENSE](LICENSE).
