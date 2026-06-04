#!/bin/sh
set -eu

TARGET_VERSION="${1:-}"

if [ -z "$TARGET_VERSION" ]; then
  echo "Usage: ./scripts/rollback.sh <version>"
  echo "Exemple: ./scripts/rollback.sh v1.0.0"
  echo ""
  echo "Images disponibles :"
  docker images | grep shoplite
  exit 1
fi

echo "=== Rollback vers $TARGET_VERSION ==="

echo "1. Vérification de l'image cible..."
if ! docker images --format "{{.Repository}}:{{.Tag}}" | grep -q "shoplite-api:$TARGET_VERSION"; then
  echo "ERREUR : image shoplite-api:$TARGET_VERSION introuvable"
  docker images | grep shoplite
  exit 1
fi

echo "2. Sauvegarde PostgreSQL avant rollback..."
./scripts/backup.sh

echo "3. Export des logs avant rollback..."
docker compose logs api > "/tmp/api-logs-before-rollback-$(date +%Y%m%d-%H%M%S).log" 2>&1 || true
echo "Logs sauvegardés dans /tmp/"

echo "4. Rollback sans supprimer les volumes (JAMAIS docker compose down -v)..."
APP_VERSION="$TARGET_VERSION" docker compose up -d --no-deps api

echo "5. Attente du démarrage (15s)..."
sleep 15

echo "6. Smoke tests post-rollback..."
BASE_URL="${BASE_URL:-http://localhost:8080}"
FAIL=0

check() {
  RESULT=$(curl -s -o /dev/null -w "%{http_code}" "$1")
  if [ "$RESULT" = "$2" ]; then
    echo "OK    $1 → HTTP $RESULT"
  else
    echo "FAIL  $1 → HTTP $RESULT (attendu $2)"
    FAIL=1
  fi
}

check "$BASE_URL/api/health" "200"
check "$BASE_URL/api/products" "200"

if [ $FAIL -eq 1 ]; then
  echo "=== ROLLBACK FAILED — vérifier les logs ==="
  exit 1
fi

echo ""
echo "=== ROLLBACK TERMINÉ ==="
echo "Version : $TARGET_VERSION"
echo "Date    : $(date)"
echo "Statut  : Service restauré, données PostgreSQL préservées"
