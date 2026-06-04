# Guide de contribution — ShopLite

## Branches

| Branche | Rôle |
|---|---|
| `main` | Production stable, protégée, PR obligatoire |
| `develop` | Intégration continue, déploiement staging auto |
| `feature/*` | Nouvelles fonctionnalités |
| `hotfix/*` | Correctifs urgents depuis main |

## Commits conventionnels

```
feat:     nouvelle fonctionnalité
fix:      correction de bug
docs:     documentation uniquement
ci:       workflows CI/CD
chore:    configuration, dépendances
test:     ajout ou modification de tests
```

## Pull Requests

- Toujours créer une PR pour merger vers `develop` ou `main`
- Au moins une review du binôme obligatoire
- CI verte avant de merger

## Gestion des secrets

- Ne jamais commiter `.env`
- Utiliser `.env.example` avec des valeurs fictives (`CHANGEME`)
- Les vrais secrets sont dans GitHub Secrets (Settings → Secrets)

### Rotation des secrets

| Secret | Rotation conseillée |
|---|---|
| `POSTGRES_PASSWORD` | Tous les 90 jours |
| `DATABASE_URL` | À chaque rotation du mot de passe |

## Checklist sécurité

- [ ] Aucun mot de passe dans le code ou les logs
- [ ] `.env` absent du dépôt Git
- [ ] `npm audit` sans vulnérabilité critique
- [ ] Ports exposés limités au nécessaire
- [ ] Image Docker scannée par Trivy en CI

## Classement des risques

| Risque | Niveau | Action |
|---|---|---|
| Secret commité dans Git | Critique | Révoquer + rotation immédiate |
| Vulnérabilité npm CRITICAL | Critique | Patcher avant déploiement |
| Image de base non à jour | Moyen | Mettre à jour dans la semaine |
| Vulnérabilité npm HIGH | Moyen | Planifier le correctif |
| Dépendance obsolète | Faible | Mettre à jour au prochain sprint |
