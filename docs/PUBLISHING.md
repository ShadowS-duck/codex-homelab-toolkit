# Publishing Model

## Stages

1. Repository source, tests, documentation, and tagged releases.
2. Project marketplace installation from a pinned Git source.
3. Validated, versioned plugin ZIP and checksum artifact.
4. Directory submission after privacy, security, support, and review gates.

A public repository is not automatically a public plugin listing.

## Release gate

- repository validation passes;
- no placeholders, secrets, or environment-specific identifiers;
- every skill has a declared maturity;
- scripts have representative execution tests;
- plugin install and reinstall are verified;
- license and security policy are present;
- privacy impact and external dependencies are documented;
- semantic version and release notes are prepared.

Version `0.1.0` verifies Stages 1 through 3 as a pre-stable GitHub release.
Stage 4 is not claimed: repository publication and personal marketplace
installation do not create a universal Codex directory listing.
