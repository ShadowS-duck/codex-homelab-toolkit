# State Model

- **Observed:** timestamped, sanitized evidence from the live system.
- **Desired:** reviewed version-controlled configuration.
- **Derived:** reports generated from observed or desired sources.
- **Secret:** protected data never committed to normal repository history.
- **Unknown:** unverified information preserved explicitly.

When observed and desired differ, classify the drift. Do not silently overwrite
either state. Documentation may describe all classes but must label them clearly.
