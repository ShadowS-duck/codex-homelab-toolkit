---
name: review-homelab-change
description: Review a proposed homelab infrastructure change for correctness, security, reversibility, data safety, operability, documentation, and evidence. Use for scripts, Compose files, firewall rules, storage changes, upgrades, migrations, deployment plans, or pull requests. Do not execute the change or approve risk that lacks evidence.
---

# Review Homelab Change

Review as an operator who must recover the system during the worst reasonable
failure, not only as an author expecting the happy path.

## Workflow

1. Establish target, current state, desired outcome, and evidence source.
2. Read `references/risk-model.md` and assign the highest applicable risk class.
3. Trace writes, privilege changes, exposure, dependencies, and failure spread.
4. Verify preflight, backup, dry run, health check, rollback, and documentation.
5. Distinguish blocking findings from improvements and unknowns.
6. Reject “safe,” “backed up,” or “idempotent” claims without evidence.

## Output contract

Lead with findings ordered by severity. Include the affected operation, failure
scenario, safe path, and validation needed. State residual risk if none block.
