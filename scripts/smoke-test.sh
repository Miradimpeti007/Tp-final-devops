#!/bin/sh
set -eu

BASE_URL="${BASE_URL:-http://localhost:8080}"
FAIL=0

check() {
  RESULT=$(curl -s -o /dev/null -w "%{http_code}" "$1")
  if [ "$RESULT" = "$2" ]; then echo "OK    $1 → HTTP $RESULT"
  else echo "FAIL  $1 → HTTP $RESULT (attendu $2)"; FAIL=1; fi
}

echo "=== Smoke tests sur $BASE_URL ==="
check "$BASE_URL/api/health" "200"
check "$BASE_URL/api/ready" "200"
check "$BASE_URL/api/products" "200"

if [ $FAIL -eq 1 ]; then echo "=== SMOKE TESTS FAILED ==="; exit 1; fi
echo "=== SMOKE TESTS OK ==="
