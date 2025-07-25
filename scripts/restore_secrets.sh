#!/usr/bin/env bash
# ------------------------------------------------------------------
# copy-secrets.sh – replay export_secrets.txt into hayk-demo-kv
# ------------------------------------------------------------------
set -euo pipefail

SRC_FILE="export_secrets.txt"     # path to your file
DEST_VAULT="hayk-demo-kv"         # new vault name

current_name=""
current_value=""

flush_secret () {
  [[ -z "$current_name" ]] && return        # nothing buffered yet
  # Decide whether to treat the value as raw text or base64 (look at its first line)
  if [[ "$current_value" =~ ^MII ]]; then   # looks like a base-64 blob (PFX, certificate, etc.)
    az keyvault secret set \
        --vault-name  "$DEST_VAULT" \
        --name        "$current_name" \
        --value       "$current_value" \
        --encoding    base64             # tell Azure it’s base64-encoded
  else
    az keyvault secret set \
        --vault-name  "$DEST_VAULT" \
        --name        "$current_name" \
        --value       "$current_value"
  fi
}

while IFS= read -r line || [[ -n "$line" ]]; do
  if [[ "$line" == *":"* && "${line%%:*}" != "" ]]; then
    # ── New secret starts ──
    flush_secret                      # push the previously-buffered secret
    current_name="${line%%:*}"        # text before FIRST ':'  ⇒ the key name
    current_value="${line#*:}"        # everything after FIRST ':' (can be empty)
  else
    # ── Continuation line (part of the previous value) ──
    current_value+=$'\n'"$line"
  fi
done < "$SRC_FILE"

flush_secret                          # push the final buffered secret
echo -e "\n✅  All secrets copied into $DEST_VAULT"
