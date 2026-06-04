# Rapport d'Incident — ShopLite

## Incident : Route /api/products cassée (v1.1.0)

### Impact
<<<<<<< HEAD
- **Service affecté** : GET /api/products — catalogue invisible pour les utilisateurs
=======
- **Service affecté** : GET /api/products — catalogue invisible
>>>>>>> origin/develop
- **Environnement** : staging
- **Durée** : ~20 minutes
- **Sévérité** : Haute

### Timeline

| Heure | Action | Responsable | Résultat |
|---|---|---|---|
| 10:05 | Détection erreur /api/products | QA | Test rouge, HTTP 500 |
<<<<<<< HEAD
| 10:08 | Analyse logs API (`docker compose logs api`) | DevOps | Erreur dans la route products |
| 10:10 | Vérification Git (`git log --oneline`) | API | Commit suspect identifié |
| 10:12 | Vérification PostgreSQL (`docker compose exec db psql`) | DBA | Données présentes, DB OK |
| 10:15 | Décision rollback | PO + Incident Manager | Rollback validé vers v1.0.0 |
| 10:16 | Backup PostgreSQL (`./scripts/backup.sh`) | DBA | Dump créé avec succès |
| 10:18 | Rollback (`./scripts/rollback.sh v1.0.0`) | DevOps | API redémarrée |
| 10:22 | Smoke tests (`./scripts/smoke-test.sh`) | QA | Tests verts |
| 10:25 | Communication finale | Incident Manager | Incident clos |

### Cause racine
Modification de la route `/api/products` en v1.1.0 introduisant une erreur de traitement des données. Le test automatisé sur `/api/products` a détecté l'anomalie immédiatement.
=======
| 10:08 | Analyse logs API | DevOps | Erreur dans la route products |
| 10:10 | Vérification Git | Dev API | Commit suspect identifié |
| 10:12 | Vérification PostgreSQL | DBA | Données présentes, DB OK |
| 10:15 | Décision rollback | PO + Incident Manager | Rollback validé vers v1.0.0 |
| 10:16 | Backup PostgreSQL | DBA | Dump créé avec succès |
| 10:18 | Rollback vers v1.0.0 | DevOps | API redémarrée |
| 10:22 | Smoke tests | QA | Tests verts |
| 10:25 | Communication finale | Incident Manager | Incident clos |

### Cause racine
Modification de la route `/api/products` en v1.1.0 introduisant une erreur.
>>>>>>> origin/develop

### Commandes utilisées

```bash
<<<<<<< HEAD
# Diagnostic
docker compose logs api --tail=50
curl http://localhost:8080/api/health
curl http://localhost:8080/api/products
git log --oneline -5

# Backup avant rollback
./scripts/backup.sh

# Rollback
./scripts/rollback.sh v1.0.0

# Vérification
./scripts/smoke-test.sh
cd api && npm test
```

### Actions correctives
- Rollback vers v1.0.0 effectué sans suppression des volumes
- Données PostgreSQL préservées (volumes non touchés)
- Tests automatisés ont détecté l'incident avant mise en production

### Prévention
- Tests automatisés CI obligatoires sur /api/products
- Smoke tests post-déploiement systématiques
- Script rollback testé et documenté
- Backup avant tout rollback
=======
docker compose logs api --tail=50
curl http://localhost:8080/api/health
git log --oneline -5
./scripts/backup.sh
./scripts/rollback.sh v1.0.0
./scripts/smoke-test.sh
```

### Prévention
- Tests automatisés CI sur /api/products
- Smoke tests post-déploiement obligatoires
- Script rollback testé et documenté
>>>>>>> origin/develop
