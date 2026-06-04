# Architecture — ShopLite

## Diagramme

```mermaid
graph TD
<<<<<<< HEAD
    User[Utilisateur] -->|HTTP| Proxy["nginx reverse proxy\n:8080 dev\n:8081 staging\n:8082 prod"]
    Proxy -->|/api/*| API["Node.js API\n:3000"]
    Proxy -->|/*| Frontend["nginx Frontend\n:80"]
    API -->|SQL| DB[(PostgreSQL\nshoplite_pgdata)]

    subgraph CI_CD["CI/CD GitHub Actions"]
        Push[Push / PR] --> CI["CI\nlint + test + build + trivy"]
        CI -->|develop| CDStaging["CD staging\nport 8081"]
        CI -->|tag v*| CDProd["CD production\nport 8082\napprobation manuelle"]
    end

    subgraph Observabilite["Observabilité"]
        API -->|GET /health| Health["status + version\n+ db check"]
        API -->|GET /ready| Ready["readiness check"]
        API -->|JSON logs| Logs["request_id\nniveau info/warn/error"]
=======
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
>>>>>>> origin/develop
    end
```

## Services

| Service | Image | Port interne | Port exposé (dev) |
|---|---|---|---|
| proxy | nginx:1.27-alpine | 80 | 8080 |
<<<<<<< HEAD
| api | shoplite-api:local | 3000 | — |
| frontend | shoplite-frontend:local | 80 | — |
=======
| api | shoplite-api | 3000 | — |
| frontend | shoplite-frontend | 80 | — |
>>>>>>> origin/develop
| db | postgres:16-alpine | 5432 | — |

## Flux de déploiement

```
<<<<<<< HEAD
feature/* → push → CI (lint + test + build)
develop   → merge → CI + CD staging  (port 8081, automatique)
tag v*    → push → CI + CD production (port 8082, approbation manuelle)
```

## Volumes et données

- `shoplite_pgdata` — données PostgreSQL dev
- `shoplite_pgdata_staging` — données PostgreSQL staging
- `shoplite_pgdata_prod` — données PostgreSQL production
=======
feature/* → CI (lint + test + build)
develop   → CI + CD staging  (port 8081, automatique)
tag v*    → CI + CD production (port 8082, approbation manuelle)
```

## Volumes

- `shoplite_pgdata` — données PostgreSQL dev
- `shoplite_pgdata_staging` — données PostgreSQL staging
>>>>>>> origin/develop
- `./backups/` — dumps SQL horodatés (rétention 7 jours)

## Logs en production

<<<<<<< HEAD
En production, les logs JSON seraient centralisés via un stack **ELK** (Elasticsearch, Logstash, Kibana) ou **Loki + Grafana**, en récupérant les logs Docker avec le driver `json-file`.
=======
Les logs JSON seraient centralisés via **Loki + Grafana** ou **ELK**, en récupérant les logs Docker avec le driver `json-file`.
>>>>>>> origin/develop
