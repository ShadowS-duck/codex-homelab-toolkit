# Bootstrap Phases

1. Verify identity, OS support, time, boot, storage, and recovery access.
2. Fix critical configuration warnings without removing current access.
3. Configure update and package-source policy with rollback expectations.
4. Establish firewall defaults while preserving administration access.
5. Add private remote access and test it before restricting local access.
6. Add storage health, monitoring, and capacity thresholds.
7. Install container runtime with pinned repositories and version policy.
8. Establish secret, configuration, data, backup, and restore contracts.
9. Add services one at a time with health checks and rollback.
10. Verify rebuild documentation in an isolated or disposable environment.

Do not combine storage erasure, firewall lock-down, credential rotation, and
service deployment into one approval or rollback boundary.
