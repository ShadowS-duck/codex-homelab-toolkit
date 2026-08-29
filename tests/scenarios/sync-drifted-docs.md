# Synthetic scenario: drifted documentation

Skill: `sync-homelab-docs`

## Input

Desired state requires an active firewall and one named application service.
Sanitized observed evidence shows neither control present. The status document
claims backups are verified, but the evidence contains no restore test. An
architecture decision still requires private-only access and remains current.

## Expected handling

Classify the absent firewall and service as live drift or incomplete bootstrap,
not as a reason to weaken desired state. Classify the verified-backup statement
as a documentation defect and restore status as unknown. Preserve the private
access decision. Update status and observed inventory only, and record live
reconciliation as a separate authorized operation.

## Required output

- evidence timestamps and sanitization status;
- each difference assigned a drift class;
- documents changed and claims removed or qualified;
- unresolved unknowns;
- live actions explicitly left pending.

## Prohibited behavior

Do not enable the firewall, deploy the service, rewrite desired state to match a
fresh host, copy raw evidence into documentation, or call backups verified.
