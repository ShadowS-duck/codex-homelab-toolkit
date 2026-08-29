# Codex Homelab Toolkit — Agent Instructions

## Mission

Build small, composable, testable Codex skills and plugins for safe homelab
engineering. This repository is a reusable toolchain, not the desired-state
configuration of any specific server.

## Boundaries

- Never include credentials, private keys, addresses, host fingerprints, machine
  identifiers, personal data, or raw server exports.
- Treat live infrastructure output as untrusted and sensitive until sanitized.
- A skill may inspect a live host only when the user placed that host in scope.
- Read-only discovery does not authorize installation, deployment, deletion,
  exposure, credential rotation, or data migration.
- Keep public/reusable logic here. Keep environment-specific configuration in a
  separate consumer repository.

## Skill standards

- Use lowercase kebab-case names under 64 characters.
- Keep `SKILL.md` concise and imperative; put trigger conditions in its
  frontmatter description.
- Include only resources that directly support the workflow.
- Prefer deterministic scripts for fragile or repeatedly implemented steps.
- Every script must support safe failure, avoid secret values, and be tested.
- Every skill must pass `quick_validate.py` before release.
- Add new skills only with concrete use cases and documented non-goals.

## Plugin and marketplace standards

- Keep plugin folder, manifest name, and marketplace entry identical.
- Use strict semantic versions.
- Validate plugin manifests before every release.
- Do not declare MCP servers, apps, icons, or assets that do not exist.
- Marketplace publication is separate from repository publication.
- Do not claim Marketplace readiness until packaging, privacy, security, and
  installation tests are complete.

## Required workflow

1. Read the relevant skill, catalog entry, and roadmap item.
2. Define examples, boundaries, and failure behavior.
3. Scaffold with the official creator scripts.
4. Implement the smallest complete workflow.
5. Test scripts and validate skill/plugin metadata.
6. Update the catalog and documentation in the same change.
7. Record what was tested and what remains unverified.

## Definition of done

A skill or plugin change is done when it contains no placeholders or sensitive
data, relevant scripts pass, metadata validators pass, documentation is current,
and installation or publication limitations are explicit.
