# Indicateurs DORA — ShopLite

## Les 4 métriques

### 1. Lead Time for Changes
| Période | Lead Time | Niveau |
|---|---|---|
| TP (simulation) | ~30 min | Elite (< 1h) |

### 2. Deployment Frequency
| Période | Fréquence | Niveau |
|---|---|---|
| TP (simulation) | À chaque tag v* | High |

### 3. Mean Time to Restore (MTTR)
| Incident | MTTR | Niveau |
|---|---|---|
| Route /api/products | ~20 min | Elite (< 1h) |

### 4. Change Failure Rate
| Déploiements | Incidents | Taux | Niveau |
|---|---|---|---|
| 3 | 1 (contrôlé) | 33%* | Low |

*Incident volontaire dans le cadre du TP.

## Tableau de synthèse

| Métrique | Notre valeur | Elite | High | Medium | Low |
|---|---|---|---|---|---|
| Lead time | ~30 min | < 1h | 1j–1sem | 1sem–1mois | > 1mois |
| Deploy freq | /tag v* | Plusieurs/jour | 1/semaine | 1/mois | < 1/6mois |
| MTTR | ~20 min | < 1h | < 1j | < 1sem | > 1sem |
| Change fail rate | 33%* | < 5% | 5–10% | 11–30% | > 30% |
