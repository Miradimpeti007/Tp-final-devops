# Changelog

## [v1.1.0] - 2026-06-04

### Ajouté
- Incident contrôlé sur /api/products (scénario de rollback)
- Colonne `stock` dans la table products (migration non destructive)

### Modifié
- Route /api/products modifiée volontairement pour tester le rollback

## [v1.0.0] - 2026-06-04

### Ajouté
- Dockerfiles API et frontend avec healthcheck et labels OCI
- Docker Compose avec staging (8081) et production (8082) override
- CI/CD GitHub Actions : lint, test matrix Node 18/20, build, scan Trivy, deploy
- Tests unitaires avec couverture 80% (health, products, 404, 500)
- Observabilité : /health avec version, /ready, logs JSON avec request_id
- Sanitisation des logs (masquage des secrets dans les URLs)
- Backup PostgreSQL automatisé avec rétention 7 jours
- Scripts rollback et smoke-test fonctionnels
- Documentation complète (README, ARCHITECTURE, INCIDENT, DORA, RACI)
- Multi-environnements : dev/staging/prod avec ports distincts

## [0.1.0] - Initial

- Projet starter ShopLite
