# Release Gates

## Skill maturity

### Experimental

- valid skill metadata and focused trigger description;
- documented workflow, safety rules, and output contract;
- repository validation passes.

### Tested

- all experimental requirements;
- mapped synthetic acceptance scenario with required and prohibited behavior;
- deterministic scripts have automated tests;
- plugin install and reinstall from the published marketplace succeed;
- the main branch passes continuous integration.

### Stable

- all tested requirements;
- bounded use on a disposable or explicitly authorized target;
- compatibility and failure cases recorded;
- upgrade and rollback behavior verified across released versions;
- tagged release, changelog, privacy review, and support policy.

## Current gate

The four foundation skills satisfy the tested gate. The plugin remains a
pre-stable `0.1.0` release because bounded target use, version-to-version
upgrade, rollback, and a tagged release have not yet been completed.

The live Raspberry is not used to prove basic contracts. Its sanitized baseline
may be used only after synthetic scenarios pass, and any mutation remains a
separate consumer-repository operation.
