---
name: audit-homelab-host
description: Collect and assess a sanitized, read-only Linux homelab host baseline covering identity, OS, boot, capacity, storage, services, listeners, updates, and security posture. Use for fresh-install verification, pre-migration discovery, incident baselining, inventory refresh, or drift investigation. Do not use to install, repair, deploy, mount, erase, or otherwise mutate a host.
---

# Audit Homelab Host

Collect evidence without changing the target, then distinguish verified facts,
unknowns, risks, and recommended next checks.

## Workflow

1. Confirm the exact target and that read-only inspection is authorized.
2. Verify host identity before authentication. Stop on an unexplained key change.
3. Keep raw output ephemeral by default.
4. Run `scripts/collect-linux-baseline.sh` locally on the target or through a
   bounded SSH command. Do not add mutating commands to the same session.
5. Read `references/sanitization.md` before storing or sharing results.
6. Classify every claim as observed, derived, or unknown.
7. Report health, exposure, missing controls, limitations, and next safe checks.

## Safety rules

- Do not run package updates, mounts, writing filesystem checks, service
  restarts, or container commands with side effects.
- Do not collect environment values, secret files, SSH keys, serials, UUIDs,
  MAC addresses, public addresses, or application data.
- Do not treat a clean result as proof that uninspected media is blank.
- Do not call a backup valid without restore evidence.
- Record unavailable tools and incomplete checks explicitly.

## Output contract

Produce provenance, sanitized observations, risks, unknowns, and next actions.
Distinguish a clean host, a healthy host, and a host ready for its intended role.
