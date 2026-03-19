#!/bin/bash

echo "🔧 Gerando google-services.json..."

if [ -z "$GOOGLE_SERVICES_JSON" ]; then
  echo "❌ Variável GOOGLE_SERVICES_JSON não definida"
  exit 1
fi

mkdir -p android/app

echo $GOOGLE_SERVICES_JSON | base64 --decode > android/app/google-services.json

echo "✅ Arquivo gerado com sucesso"