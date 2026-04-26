prepare_social_config:
	@mkdir -p ios/Flutter
	@printf "FACEBOOK_APP_ID=%s\nFACEBOOK_CLIENT_TOKEN=%s\n" "$$FACEBOOK_APP_ID" "$$FACEBOOK_CLIENT_TOKEN" > ios/Flutter/FacebookConfig.xcconfig

run:
	@echo "🚀 Rodando app"
	@export $$(grep -v '^#' .env | xargs) && \
	$(MAKE) prepare_social_config && \
	echo $$GOOGLE_SERVICES_JSON | base64 --decode > android/app/google-services.json && \
	fvm flutter run

build:
	@echo "📦 Build app"
	@export $$(grep -v '^#' .env | xargs) && \
	$(MAKE) prepare_social_config && \
	echo $$GOOGLE_SERVICES_JSON | base64 --decode > android/app/google-services.json && \
	fvm flutter build apk

translate:
	@echo "🌍 Gerando traduções (ARB → Dart)"
	fvm flutter gen-l10n
