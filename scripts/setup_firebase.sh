#!/bin/bash

set -euo pipefail

echo "🔧 Configurando arquivos nativos do Firebase..."

if [ -n "${GOOGLE_SERVICES_JSON:-}" ]; then
  mkdir -p android/app
  echo "$GOOGLE_SERVICES_JSON" | base64 --decode > android/app/google-services.json
  echo "✅ android/app/google-services.json gerado com sucesso"
else
  echo "ℹ️ Variável GOOGLE_SERVICES_JSON não definida; mantendo configuração atual do Android"
fi

if [ -n "${GOOGLE_SERVICE_INFO_PLIST:-}" ]; then
  mkdir -p ios/Runner
  echo "$GOOGLE_SERVICE_INFO_PLIST" | base64 --decode > ios/Runner/GoogleService-Info.plist
  echo "✅ ios/Runner/GoogleService-Info.plist gerado com sucesso"
else
  echo "ℹ️ Variável GOOGLE_SERVICE_INFO_PLIST não definida; mantendo configuração atual do iOS"
fi

if [ -z "${GOOGLE_SERVICES_JSON:-}" ] && [ -z "${GOOGLE_SERVICE_INFO_PLIST:-}" ]; then
  echo "❌ Nenhuma variável de ambiente do Firebase foi informada"
  exit 1
fi
