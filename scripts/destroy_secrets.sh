#!/usr/bin/env bash
# -------------------------------------------------------------
# nuke-secrets.sh – delete (and purge) every secret in a vault
# -------------------------------------------------------------
set -euo pipefail

VAULT="hayk-demo-kv"   # ← change if you ever rename the vault

echo "🚨  Deleting all secrets in $VAULT …"

# 1. Delete every secret (moves them to the “deleted” list)
az keyvault secret list               \
  --vault-name "$VAULT"               \
  --query "[].name" -o tsv            |
while read -r NAME; do
  echo "  • deleting $NAME"
  az keyvault secret delete \
       --vault-name "$VAULT" --name "$NAME"  >/dev/null
done

# 2. Purge them (skip this block if you want to keep soft-delete recovery)
echo "🚨  Purging deleted secrets …"
az keyvault secret list-deleted \
  --vault-name "$VAULT"         \
  --query "[].name" -o tsv      |
while read -r NAME; do
  echo "  • purging $NAME"
  az keyvault secret purge \
       --vault-name "$VAULT" --name "$NAME"  >/dev/null
done

echo "✅  Vault $VAULT is now empty."
