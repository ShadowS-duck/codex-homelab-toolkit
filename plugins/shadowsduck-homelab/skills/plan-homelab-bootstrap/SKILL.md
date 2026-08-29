---
name: plan-homelab-bootstrap
description: Design a secure, phased, reversible bootstrap plan for a fresh or rebuilt Linux homelab host. Use after a verified baseline when planning users, SSH, updates, firewall, VPN, storage health, container runtime, observability, backup, or service prerequisites. Do not use to execute installations or mutate a live host.
---

# Plan Homelab Bootstrap

Turn verified observations and requirements into an ordered bootstrap with
preflight checks, validation gates, and rollback boundaries.

## Workflow

1. Require a recent sanitized baseline; preserve unknowns instead of guessing.
2. Define access paths, exposure, data classes, and recovery needs.
3. Read `references/bootstrap-phases.md` and select applicable phases.
4. Specify prerequisites, scope, backup, dry run, implementation, validation,
   rollback, and retained evidence for every phase.
5. Separate reversible package work from destructive storage, credential, or
   network operations.
6. Stop at the first step needing a missing user decision.

## Output contract

Provide an ordered plan with risk, interruption, verification, rollback, and
approval boundaries. A command list without those controls is not a safe plan.
