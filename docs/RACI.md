# Matrice RACI — ShopLite

## Notre équipe (binôme)

| Rôle | Personne |
|---|---|
| DevOps / Release Manager | Walid |
| Développeur API + DBA | Binôme |
| QA / Testeur | Walid + Binôme |
| Incident Manager | Walid |
| Product Owner | Walid + Binôme |

## Matrice RACI

| Activité | PO | API | Frontend | DevOps | DBA | QA | Incident Manager |
|---|---|---|---|---|---|---|---|
| Créer la version stable Git | I | C | C | **R/A** | I | I | I |
| Mettre en place Docker Compose | I | C | C | **R/A** | I | I | I |
| Configurer la CI/CD | I | C | I | **R/A** | I | C | I |
| Ajouter le test /api/products | I | C | I | I | I | **R/A** | I |
| Sauvegarder PostgreSQL | I | I | I | C | **R/A** | I | I |
| Provoquer l'incident contrôlé | **A** | **R** | I | C | I | I | I |
| Diagnostiquer l'incident | C | **R** | I | **R** | C | **R** | **A** |
| Décider le rollback | **A** | C | I | C | C | C | **R** |
| Exécuter le rollback | I | C | I | **R/A** | C | I | I |
| Vérifier les données après rollback | I | I | I | C | **R/A** | C | I |
| Valider les tests après rollback | C | C | I | C | I | **R/A** | I |
| Rédiger le rapport d'incident | C | C | C | C | C | C | **R/A** |

## Légende RACI

| Lettre | Signification |
|---|---|
| **R** | Responsible — réalise l'action |
| **A** | Accountable — valide et porte la responsabilité |
| **C** | Consulted — consulté avant/pendant |
| **I** | Informed — informé du résultat |

## Timeline incident contrôlé

| Heure | Action | Responsable | Résultat |
|---|---|---|---|
| 10:05 | Détection erreur /api/products | QA | Test rouge |
| 10:08 | Analyse logs API | DevOps | Erreur route products |
| 10:12 | Vérification PostgreSQL | DBA | Données présentes |
| 10:15 | Décision rollback | PO + Incident Manager | Rollback validé |
| 10:18 | Exécution rollback.sh v1.0.0 | DevOps | API redémarrée |
| 10:22 | Smoke tests | QA | Tests verts |
| 10:25 | Communication finale | Incident Manager | Incident clos |
