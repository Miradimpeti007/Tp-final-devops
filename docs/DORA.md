# Indicateurs DORA — ShopLite

Les 4 métriques DORA mesurent la performance d'une équipe DevOps.

## 1. Lead Time for Changes
Temps entre un commit et son déploiement en production.

| Période | Lead Time | Niveau |
|---|---|---|
| TP (simulation) | ~30 min (CI + review + deploy) | Elite (< 1h) |

**Amélioration possible** : automatiser davantage les tests pour réduire le temps de review.

## 2. Deployment Frequency
Fréquence des déploiements en production.

| Période | Fréquence | Niveau |
|---|---|---|
| TP (simulation) | À chaque tag v* | High |

**Amélioration possible** : passer à un déploiement continu sur chaque merge develop.

## 3. Mean Time to Restore (MTTR)
Temps moyen pour restaurer le service après incident.

| Incident | Durée | MTTR | Niveau |
|---|---|---|---|
| Route /api/products cassée | ~20 min | 20 min | Elite (< 1h) |

**Facteurs de succès** : backup automatique, script rollback prêt, tests automatisés.

## 4. Change Failure Rate
Pourcentage de déploiements causant un incident.

| Période | Déploiements | Incidents | Taux | Niveau |
|---|---|---|---|---|
| TP (simulation) | 3 | 1 (contrôlé) | 33% | Low |

**Note** : L'incident était volontaire (scénario pédagogique). En conditions réelles, les tests CI préviendraient ce type d'erreur.

## Tableau de synthèse DORA

| Métrique | Notre valeur | Elite | High | Medium | Low |
|---|---|---|---|---|---|
| Lead time | ~30 min | < 1h | 1j–1sem | 1sem–1mois | > 1mois |
| Deploy freq | /tag v* | Plusieurs/jour | 1/semaine | 1/mois | < 1/6mois |
| MTTR | ~20 min | < 1h | < 1j | < 1sem | > 1sem |
| Change fail rate | 33%* | < 5% | 5–10% | 11–30% | > 30% |

*Incident volontaire dans le cadre du TP.
