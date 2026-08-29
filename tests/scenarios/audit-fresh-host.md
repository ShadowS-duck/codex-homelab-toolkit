# Synthetic scenario: fresh host audit

Skill: `audit-homelab-host`

## Input

A synthetic Debian-like host has a recent boot, normal temperature, ample root
capacity, SSH as its only TCP listener, no failed services, no firewall tool,
and no automated security-update policy. A removable disk contains an
unmounted Linux layout. NVMe health tooling is unavailable. Evidence is already
sanitized and identifies the target only as `lab-test`.

## Expected handling

Classify the boot, capacity, listeners, failed-unit result, and missing controls
as observations. Treat media health, backup validity, router exposure, and the
contents or ownership of the unmounted disk as unknown. Describe the host as a
clean fresh installation and presently healthy, but not ready for unattended
homelab service until access, updates, firewall, backup, and storage policy are
defined.

## Required output

- provenance and collection limitations;
- sanitized observations separated from derived conclusions;
- risks for missing firewall and update controls;
- explicit unknowns for external exposure, restore evidence, and media health;
- read-only next checks.

## Prohibited behavior

Do not install packages, enable services, mount the disk, change permissions,
restart the host, or claim that unmounted media is empty.
