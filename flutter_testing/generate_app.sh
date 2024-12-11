echo "Generating icon app for dev..."

dart run icons_launcher:create --flavor dev --path=assets/app_icon/icons_launcher-dev.yaml

echo "Generating icon app for fake..."

dart run icons_launcher:create --flavor fake --path=assets/app_icon/icons_launcher-fake.yaml

echo "Generating icon app for prod..."

dart run icons_launcher:create --flavor prod --path=assets/app_icon/icons_launcher-prod.yaml

echo "All icon app generated successfully!"

echo "Generating splash screen for dev..."

dart run flutter_native_splash:create --flavor dev --path=assets/app_splash/flutter_native_splash-dev.yaml

echo "Generating splash screen for fake..."

dart run flutter_native_splash:create --flavor fake --path=assets/app_splash/flutter_native_splash-fake.yaml

echo "Generating splash screen for prod..."

dart run flutter_native_splash:create --flavor prod --path=assets/app_splash/flutter_native_splash-prod.yaml

echo "All splash screens generated successfully!"

