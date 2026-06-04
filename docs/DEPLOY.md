# Journal de déploiement — ShopLite

## Environnements

| Env | Port | URL locale | Branche/Tag |
|---|---|---|---|
| dev | 8080 | http://localhost:8080 | feature/* |
| staging | 8081 | http://localhost:8081 | develop |
| production | 8082 | http://localhost:8082 | tag v* |

## Commandes de déploiement

<<<<<<< HEAD
### Dev
```bash
docker compose up -d --build
```

### Staging
```bash
docker compose -f docker-compose.yml -f docker-compose.staging.yml up -d --build
```

### Production simulée
```bash
=======
```bash
# Dev
docker compose up -d --build

# Staging
docker compose -f docker-compose.yml -f docker-compose.staging.yml up -d --build

# Production simulée
>>>>>>> origin/develop
APP_VERSION=v1.0.0 docker compose -f docker-compose.yml -f docker-compose.prod.yml up -d --build
```

## Plan de retour arrière

<<<<<<< HEAD
Si une version cassée est déployée :

```bash
# 1. Sauvegarder les données
./scripts/backup.sh

# 2. Identifier la version stable disponible
docker images | grep shoplite

# 3. Rollback vers la version stable
./scripts/rollback.sh v1.0.0

# 4. Vérifier
./scripts/smoke-test.sh
```

**Règle absolue : ne jamais utiliser `docker compose down -v` — cela supprime les volumes PostgreSQL.**
=======
```bash
./scripts/backup.sh
docker images | grep shoplite
./scripts/rollback.sh v1.0.0
./scripts/smoke-test.sh
```

> Ne jamais utiliser `docker compose down -v`
>>>>>>> origin/develop

## Historique des déploiements

| Date | Version | Auteur | Environnement | Résultat |
|---|---|---|---|---|
| 2026-06-04 | v1.0.0 | Walid + binôme | staging | OK |
