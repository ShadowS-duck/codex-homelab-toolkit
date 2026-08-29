---
name: sync-homelab-docs
description: Reconcile sanitized observed state, version-controlled desired state, architecture decisions, status, inventory, and runbooks without silently changing infrastructure. Use after discovery, configuration changes, drift detection, incident recovery, service upgrades, or documentation audits. Do not treat stale docs or live drift as automatically authoritative.
---

# Sync Homelab Docs

Synchronize knowledge by classifying evidence and drift, not by copying live
output into prose.

## Workflow

1. Read `references/state-model.md`.
2. Identify collection timestamps and reject unsanitized evidence.
3. Compare observed facts with desired configuration and documentation.
4. Classify differences as expected, desired-state defect, live drift,
   documentation defect, or unknown.
5. Update only repository knowledge authorized by the evidence.
6. Record unresolved drift without repairing it implicitly.
7. Keep status, inventory, architecture, ADRs, and runbooks consistent.

## Output contract

Report documents changed, evidence used, drift classes, unknowns, and any live
reconciliation still requiring a separate authorized operation.
