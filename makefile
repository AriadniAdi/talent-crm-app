run:
	@echo "🚀 Rodando app"
	@export $$(grep -v '^#' .env | xargs) && \
	echo $$GOOGLE_SERVICES_JSON | base64 --decode > android/app/google-services.json && \
	fvm flutter run

build:
	@echo "📦 Build app"
	@export $$(grep -v '^#' .env | xargs) && \
	echo $$GOOGLE_SERVICES_JSON | base64 --decode > android/app/google-services.json && \
	fvm flutter build apk