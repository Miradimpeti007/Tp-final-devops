#!/bin/sh
set -eu

BACKUP_DIR="${BACKUP_DIR:-./backups}"
CONTAINER="${DB_CONTAINER:-shoplite_db}"
DB_NAME="${POSTGRES_DB:-shoplite}"
DB_USER="${POSTGRES_USER:-shoplite}"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
BACKUP_FILE="$BACKUP_DIR/backup-$TIMESTAMP.sql"
MAX_BACKUPS="${MAX_BACKUPS:-7}"

mkdir -p "$BACKUP_DIR"

echo "=== Backup PostgreSQL ==="
echo "Base     : $DB_NAME"
echo "Fichier  : $BACKUP_FILE"

docker exec "$CONTAINER" pg_dump -U "$DB_USER" "$DB_NAME" > "$BACKUP_FILE"

SIZE=$(du -sh "$BACKUP_FILE" | cut -f1)
echo "Backup créé : $BACKUP_FILE ($SIZE)"

# Rétention : garder seulement les MAX_BACKUPS derniers
BACKUP_COUNT=$(ls "$BACKUP_DIR"/backup-*.sql 2>/dev/null | wc -l | tr -d ' ')
if [ "$BACKUP_COUNT" -gt "$MAX_BACKUPS" ]; then
  ls -t "$BACKUP_DIR"/backup-*.sql | tail -n +$((MAX_BACKUPS + 1)) | xargs rm -f
  echo "Rétention : max $MAX_BACKUPS backups conservés"
fi

echo "=== Backup terminé ==="
