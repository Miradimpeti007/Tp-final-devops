# Architecture — ShopLite

## Diagramme

```mermaid
graph TD
    User[Utilisateur] -->|HTTP| Proxy["nginx reverse proxy\n:8080 dev / :8081 staging / :8082 prod"]
    Proxy -->|/api/*| API["Node.js API :3000"]
    Proxy -->|/*| Frontend["nginx Frontend :80"]
    API -->|SQL| DB[(PostgreSQL)]

    subgraph CI_CD["CI/CD GitHub Actions"]
        Push[Push / PR] --> CI["CI lint + test + build + trivy"]
        CI -->|develop| CDStaging["CD staging :8081"]
        CI -->|tag v*| CDProd["CD production :8082"]
    end

    subgraph Observabilite["Observabilité"]
        API -->|GET /health| Health["status + version + db check"]
        API -->|GET /ready| Ready["readiness check"]
        API -->|JSON logs| Logs["request_id + niveau info/warn/error"]
    end
```

## Services

| Service | Image | Port interne | Port exposé (dev) |
|---|---|---|---|
| proxy | nginx:1.27-alpine | 80 | 8080 |
| api | shoplite-api | 3000 | — |
| frontend | shoplite-frontend | 80 | — |
| db | postgres:16-alpine | 5432 | — |

## Flux de déploiement

```
feature/* → CI (lint + test + build)
develop   → CI + CD staging  (port 8081, automatique)
tag v*    → CI + CD production (port 8082, approbation manuelle)
```

## Volumes

- `shoplite_pgdata` — données PostgreSQL dev
- `shoplite_pgdata_staging` — données PostgreSQL staging
- `./backups/` — dumps SQL horodatés (rétention 7 jours)

## Logs en production

Les logs JSON seraient centralisés via **Loki + Grafana** ou **ELK**, en récupérant les logs Docker avec le driver `json-file`.
