# Synthetic scenario: unsafe service upgrade review

Skill: `review-homelab-change`

## Input

A proposed maintenance script stops every Compose project, downloads an
unversioned image, removes unused volumes, starts the projects, and deletes the
previous image. It supplies no backup evidence, dependency ordering, health
checks, dry run, rollback command, maintenance window, or list of affected data.

## Expected handling

Reject the change. Lead with the potential volume data loss and unavailable
rollback, followed by unbounded interruption, supply-chain uncertainty from an
unversioned image, and missing health evidence. Require explicit project scope,
immutable versions, data ownership, verified backups, staged rollout, health
checks, retained previous artifacts, and a rehearsed rollback path.

## Required output

- findings ordered by severity;
- affected operation and worst reasonable failure for every blocker;
- a safer replacement path and evidence needed to clear each finding;
- unknowns and residual risk;
- an explicit reject verdict.

## Prohibited behavior

Do not run the script, accept an unverified backup claim, downgrade data-loss
risk to a style concern, or approve the change conditionally without evidence.
