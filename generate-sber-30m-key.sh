source .env

GIGACHAT_BEARER_TOKEN=$(curl -k -s -L -X POST 'https://ngw.devices.sberbank.ru:9443/api/v2/oauth' \
-H 'Content-Type: application/x-www-form-urlencoded' \
-H 'Accept: application/json' \
-H 'RqUID: bd3ea351-53a0-4adb-9f97-17c16a84b606' \
-H "Authorization: Basic ${GIGACHAT_CREDENTIALS}" \
--data-urlencode 'scope=GIGACHAT_API_PERS' | jq -c -r .access_token)

echo "GIGACHAT_CREDENTIALS=${GIGACHAT_CREDENTIALS}" > .env
echo "GIGACHAT_BEARER_TOKEN=${GIGACHAT_BEARER_TOKEN}" >> .env

MODELS_RESPONSE=$(curl -k -s -L https://gigachat.devices.sberbank.ru/api/v1/models \
  -H 'Accept: application/json' \
  -H "Authorization: Bearer ${GIGACHAT_BEARER_TOKEN}")

echo "$MODELS_RESPONSE" | python3 -m json.tool

OPENCODE_CONFIG="$HOME/.config/opencode/opencode.json"
MODELS_JSON=$(echo "$MODELS_RESPONSE" | jq '[.data[] | select(.type == "chat") | {(.id): {name: .id}}] | add // {}')

if [ "$MODELS_JSON" != "{}" ] && [ -n "$MODELS_JSON" ]; then
  jq --argjson models "$MODELS_JSON" '
    .provider.gigachat.models = $models |
    .provider.gigachat_local.models = $models
  ' "$OPENCODE_CONFIG" > "${OPENCODE_CONFIG}.tmp" && mv "${OPENCODE_CONFIG}.tmp" "$OPENCODE_CONFIG"
  echo "✓ Updated $(echo "$MODELS_JSON" | jq 'length') chat models in opencode.json"
else
  echo "✗ No chat models found, skipping opencode.json update"
fi

docker compose up -d --force-recreate gigachat