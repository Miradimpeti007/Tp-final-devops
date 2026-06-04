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

### Règles absolues

- Ne jamais commiter `.env` (il est dans `.gitignore`)
- Ne jamais écrire un vrai mot de passe dans le code, les logs ou le Dockerfile
- Utiliser `.env.example` avec des valeurs fictives (`CHANGEME`)

### GitHub Secrets — Rotation

Les secrets sont stockés dans **GitHub Settings → Secrets and variables → Actions**.

| Secret | Environnement | Rotation conseillée |
|---|---|---|
| `POSTGRES_PASSWORD` | staging, production | Tous les 90 jours |
| `DATABASE_URL` | staging, production | À chaque rotation du mot de passe |

**Procédure de rotation :**
1. Générer un nouveau mot de passe fort
2. Mettre à jour le secret dans GitHub (Settings → Secrets)
3. Redéployer l'application avec `docker compose up -d`
4. Vérifier `/api/health` pour confirmer la connexion DB

## Checklist sécurité

Avant chaque déploiement, vérifier :

- [ ] Aucun mot de passe ou token dans le code source
- [ ] `.env` absent du dépôt Git (`git status` ne le montre pas)
- [ ] `.env.example` contient uniquement des valeurs fictives (`CHANGEME`)
- [ ] `npm audit` ne remonte aucune vulnérabilité critique
- [ ] Ports exposés limités au strict nécessaire (seul le port 80 du proxy est exposé)
- [ ] Aucun secret visible dans les logs (`docker compose logs`)
- [ ] Image Docker scannée par Trivy en CI

## Classement des risques

| Risque | Niveau | Action |
|---|---|---|
| Secret commité dans Git | **Critique** | Révoquer immédiatement + rotation |
| Vulnérabilité npm CRITICAL | **Critique** | Patcher avant déploiement |
| Image de base non à jour | **Moyen** | Mettre à jour dans la semaine |
| Vulnérabilité npm HIGH | **Moyen** | Planifier le correctif |
| Dépendance obsolète (npm outdated) | **Faible** | Mettre à jour lors du prochain sprint |
| Port non nécessaire exposé | **Faible** | Supprimer dans la prochaine PR |
