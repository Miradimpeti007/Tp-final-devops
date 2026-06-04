#!/bin/sh
set -eu

BACKUP_FILE="${1:-}"
CONTAINER="${DB_CONTAINER:-shoplite_db}"
DB_USER="${POSTGRES_USER:-shoplite}"
TEST_DB="shoplite_restore_test"

if [ -z "$BACKUP_FILE" ]; then
  BACKUP_FILE=$(ls -t ./backups/backup-*.sql 2>/dev/null | head -1 || echo "")
  if [ -z "$BACKUP_FILE" ]; then
    echo "ERREUR : aucun backup trouvé. Lancer d'abord ./scripts/backup.sh"
    exit 1
  fi
fi

echo "=== Test de restauration depuis $BACKUP_FILE ==="
docker exec "$CONTAINER" psql -U "$DB_USER" -c "DROP DATABASE IF EXISTS $TEST_DB;" postgres
docker exec "$CONTAINER" psql -U "$DB_USER" -c "CREATE DATABASE $TEST_DB;" postgres
docker exec -i "$CONTAINER" psql -U "$DB_USER" "$TEST_DB" < "$BACKUP_FILE"

PRODUCT_COUNT=$(docker exec "$CONTAINER" psql -U "$DB_USER" "$TEST_DB" -t -c "SELECT COUNT(*) FROM products;" | tr -d ' \n')
echo "Produits restaurés : $PRODUCT_COUNT"
docker exec "$CONTAINER" psql -U "$DB_USER" -c "DROP DATABASE IF EXISTS $TEST_DB;" postgres

if [ "$PRODUCT_COUNT" -gt 0 ]; then
  echo "=== RESTAURATION OK ($PRODUCT_COUNT produits) ==="
else
  echo "=== RESTAURATION KO ==="
  exit 1
fi
