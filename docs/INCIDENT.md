# Rapport d'Incident — ShopLite

## Incident : Route /api/products cassée (v1.1.0)

### Impact
- **Service affecté** : GET /api/products — catalogue invisible
- **Environnement** : staging
- **Durée** : ~20 minutes
- **Sévérité** : Haute

### Timeline

| Heure | Action | Responsable | Résultat |
|---|---|---|---|
| 10:05 | Détection erreur /api/products | QA | Test rouge, HTTP 500 |
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

### Commandes utilisées

```bash
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
