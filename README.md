# ShopLite - TP final DevOps

[![CI](https://github.com/Miradimpeti007/Tp-final-devops/actions/workflows/ci.yml/badge.svg)](https://github.com/Miradimpeti007/Tp-final-devops/actions/workflows/ci.yml)
[![CD](https://github.com/Miradimpeti007/Tp-final-devops/actions/workflows/cd.yml/badge.svg)](https://github.com/Miradimpeti007/Tp-final-devops/actions/workflows/cd.yml)

ShopLite est une mini application e-commerce industrialisée avec une chaîne DevOps complète.

## Environnements

| Environnement | Port | Branche | Commande |
|---|---|---|---|
| **dev** | 8080 | `feature/*` | `docker compose up -d --build` |
| **staging** | 8081 | `develop` | `docker compose -f docker-compose.yml -f docker-compose.staging.yml up -d --build` |
| **production** | 8082 | tag `v*` | `docker compose -f docker-compose.yml -f docker-compose.prod.yml up -d --build` |

## Lancement rapide (dev)

```bash
cp .env.example .env
# Modifier .env avec vos valeurs
docker compose up -d --build
```

Ouvrir : **http://localhost:8080**

```bash
curl http://localhost:8080/api/health
curl http://localhost:8080/api/products
```

## Lancement staging

```bash
docker compose -f docker-compose.yml -f docker-compose.staging.yml up -d --build
```

Ouvrir : **http://localhost:8081**

## Tests

```bash
cd api
npm install
npm test
npm run test:coverage
npm run lint
```

## Arrêter sans supprimer les données

```bash
docker compose down
# Ne jamais utiliser docker compose down -v (supprime les données PostgreSQL)
```

## Stack technique

- API : Node.js / Express
- Frontend : HTML / CSS / JS (nginx)
- Base de données : PostgreSQL 16
- Reverse proxy : nginx
- CI/CD : GitHub Actions
