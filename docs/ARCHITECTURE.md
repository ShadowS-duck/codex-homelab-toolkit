# Architecture

```text
Codex Homelab Toolkit
  skills + scripts + plugin + marketplace metadata
                         |
                    released version
                         v
Consumer Homelab Repository
  desired state + sanitized inventory + runbooks
                         |
                  controlled operations
                         v
Live Homelab
  observed state + private secrets + application data
```

The toolkit never becomes the source of truth for a specific machine. Consumer
repositories keep reusable workflow logic out of environment configuration.

## Components

- **Skill:** one reusable workflow with clear triggers and non-goals.
- **Script:** deterministic implementation for a narrow, repeated operation.
- **Plugin:** distribution bundle containing related skills and optional tools.
- **Marketplace manifest:** installability and presentation metadata.
- **Consumer repository:** environment-specific configuration and evidence.

## Trust model

Live-host output is untrusted input. Raw discovery output is sensitive until
sanitized. Plugin installation does not authorize live mutations. Desired state
is not assumed to match observed state. Publication requires a separate privacy
and security review.
