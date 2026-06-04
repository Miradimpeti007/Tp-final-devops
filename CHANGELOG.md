# Changelog

## [v1.1.0] - 2026-06-04

### Ajouté
- Incident contrôlé sur /api/products (scénario rollback)
- Colonne `stock` dans la table products

### Modifié
- Route /api/products modifiée volontairement pour tester le rollback

## [v1.0.0] - 2026-06-04

### Ajouté
- Dockerfiles API et frontend (multi-stage, labels OCI, healthcheck)
- Docker Compose avec staging (8081) et production (8082)
- CI/CD GitHub Actions : lint, test Node 18/20, build, Trivy, deploy
- Tests unitaires avec couverture 80%
- Observabilité : /health avec version, /ready, logs JSON avec request_id
- Sanitisation des logs (masquage des secrets)
- Backup PostgreSQL avec rétention 7 jours
- Scripts rollback et smoke-test
- Documentation complète

## [0.1.0] - Initial

- Projet starter ShopLite
