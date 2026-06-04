# ShopLite — TP Final DevOps
 
[![CI](https://github.com/Miradimpeti007/Tp-final-devops/actions/workflows/ci.yml/badge.svg)](https://github.com/Miradimpeti007/Tp-final-devops/actions/workflows/ci.yml)
[![CD](https://github.com/Miradimpeti007/Tp-final-devops/actions/workflows/cd.yml/badge.svg)](https://github.com/Miradimpeti007/Tp-final-devops/actions/workflows/cd.yml)
 
> Projet réalisé par **ALI Walid** et **Miradi Mpeti Eboma** — YNOV B3 DevOps
 
ShopLite est une mini application e-commerce industrialisée avec une chaîne DevOps complète : Git, Docker, CI/CD, observabilité, backup et rollback.
 
---
 
## Stack technique
 
| Composant | Technologie |
|---|---|
| API | Node.js / Express |
| Frontend | HTML / CSS / JS (nginx) |
| Base de données | PostgreSQL 16 |
| Reverse proxy | nginx |
| CI/CD | GitHub Actions |
| Containerisation | Docker / Docker Compose |
 
---
 
## Environnements
 
| Environnement | Port | Branche | Commande |
|---|---|---|---|
| **dev** | 8080 | `feature/*` | `docker compose up -d --build` |
| **staging** | 8081 | `develop` | `docker compose -f docker-compose.yml -f docker-compose.staging.yml up -d --build` |
| **production** | 8082 | tag `v*` | `docker compose -f docker-compose.yml -f docker-compose.prod.yml up -d --build` |
 
---
 
## Installation et lancement
 
### Prérequis
- Docker Desktop
- Node.js 18+
- Git
 
### Lancement rapide (dev)
 
```bash
git clone https://github.com/Miradimpeti007/Tp-final-devops.git
cd Tp-final-devops
cp .env.example .env
docker compose up -d --build
```
 
Ouvrir : **http://localhost:8080**
 
### Vérifier que tout fonctionne
 
```bash
curl http://localhost:8080/api/health
curl http://localhost:8080/api/ready
curl http://localhost:8080/api/products
```
 
### Arrêter sans perdre les données
 
```bash
docker compose down
```
 
> **Important** : ne jamais utiliser `docker compose down -v` — cela supprime les volumes PostgreSQL.
 
---
 
## Tests
 
```bash
cd api
npm install
npm test                # tests rapides
npm run test:coverage   # tests + rapport de couverture (seuil 80%)
npm run lint            # vérification ESLint
npm run format:check    # vérification Prettier
```
 
---
 
## Docker
 
```bash
# Build et lancement
docker compose up -d --build
 
# Vérifier l'état des services
docker compose ps
 
# Voir les logs
docker compose logs --tail=50 api
 
# Redémarrer un service
docker compose restart api
 
# Lancer en staging (port 8081)
docker compose -f docker-compose.yml -f docker-compose.staging.yml up -d --build
```
 
---
 
## CI/CD
 
Le pipeline GitHub Actions comporte 4 jobs :
 
| Job | Déclencheur | Description |
|---|---|---|
| **Lint** | push / PR | ESLint + Prettier |
| **Security** | push / PR | `npm audit` + `npm outdated` |
| **Tests** | push / PR | Jest (Node 18 + 20) + couverture |
| **Build** | après tests | Build Docker + scan Trivy |
 
Le workflow CD déploie automatiquement :
- sur `develop` → staging
- sur tag `v*` → production (approbation manuelle requise)
 
---
 
## Backup et rollback
 
```bash
# Sauvegarder PostgreSQL
./scripts/backup.sh
 
# Tester la restauration
./scripts/restore-test.sh
 
# Rollback vers une version stable
./scripts/rollback.sh v1.0.0
 
# Smoke tests post-déploiement
./scripts/smoke-test.sh
```
 
---
 
## Tableau de suivi incident
 
| Symptôme | Heure | Cause | Commande | Résultat |
|---|---|---|---|---|
| GET /api/products → 500 | 10:05 | Bug introducten v1.1.0 | `docker compose logs api` | Erreur identifiée |
| Données manquantes ? | 10:12 | Vérification DB | `docker compose exec db psql` | Données OK |
| Rollback décidé | 10:15 | v1.0.0 stable | `./scripts/rollback.sh v1.0.0` | Service restauré |
| Tests repassés | 10:22 | Rollback OK | `npm test` | ✅ Verts |
 
---
 
## Commandes de diagnostic
 
```bash
docker compose ps
docker compose logs --tail=100 api
curl http://localhost:8080/api/health
curl http://localhost:8080/api/ready
docker inspect shoplite_api
```
 
---
 
## Auteurs
 
- **ALI Walid** — DevOps, CI/CD, observabilité, rollback
- **Miradi Mpeti Eboma** — Développement API, tests, documentation
 
