# Change Risk Model

- **Critical:** can destroy irreplaceable data, expose credentials, remove all
  administration paths, or broadly publish private services.
- **High:** can interrupt multiple services, alter storage/network/security
  foundations, or require a complex restore.
- **Medium:** bounded interruption or reversible configuration change with
  tested rollback.
- **Low:** documentation or isolated validation with no live mutation.

Raise risk when the target is ambiguous, backups are untested, rollback depends
on the failed component, secrets may enter logs, or observed state is stale.
