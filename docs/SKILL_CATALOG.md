# Skill Catalog

Maturity levels are **experimental**, **tested**, and **stable**.

## Foundation set

| Skill | Maturity | Responsibility |
| --- | --- | --- |
| `audit-homelab-host` | tested | Sanitized read-only Linux host baseline |
| `plan-homelab-bootstrap` | tested | Phased bootstrap plan with gates and rollback |
| `review-homelab-change` | tested | Safety and operability review of a proposed change |
| `sync-homelab-docs` | tested | Evidence-aware reconciliation of state and docs |

## Planned operational set

| Candidate | Purpose | Prerequisite |
| --- | --- | --- |
| `bootstrap-linux-host` | Apply an approved base profile | Foundation set tested |
| `manage-compose-service` | Add, upgrade, validate, and roll back a service | Compose contract defined |
| `verify-backup-restore` | Test backup integrity and isolated restore | Data classes and RPO/RTO defined |
| `diagnose-homelab-network` | Inspect DNS, routing, ingress, VPN, and firewall | Sanitization schema defined |
| `assess-storage-health` | Inspect filesystems, NVMe/SMART, capacity, and mounts | Compatibility matrix |
| `respond-homelab-incident` | Triage, contain, recover, and preserve evidence | Incident model |
| `detect-homelab-drift` | Compare observed and desired state | Stable inventory schemas |
| `release-homelab-toolkit` | Validate, version, package, and publish | Release policy tested |

Candidates are not scaffolded until concrete examples and test fixtures exist.
This prevents metadata overload and untested implicit triggers.

See [Release Gates](RELEASE_GATES.md) for maturity evidence and the remaining
requirements for a stable release.
