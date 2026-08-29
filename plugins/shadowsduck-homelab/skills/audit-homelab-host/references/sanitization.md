# Sanitization Rules

## Omit by default

- credentials, tokens, cookies, key material, and environment values;
- machine, boot, filesystem, cloud, and account identifiers;
- MAC addresses, public addresses, and unnecessary private addresses;
- filenames or logs that expose personal content;
- serial numbers and raw application data.

## Preserve safely

- hardware class and capacity without serials;
- OS, kernel, architecture, package, and service versions;
- filesystem types, utilization percentages, and generic mount roles;
- service state and listener ports without addresses;
- timestamp, collection method, omissions, and tool failures.

Sanitize before writing to a repository. Redaction after commit is incident
response, not a normal workflow.
