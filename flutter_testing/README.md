# Flutter Testing

## Generate Flavors App

```bash
dart run flutter_flavorizr
```

## Create app icon splash with flavors

```bash
sh generate_app_icon_splash.sh
```

## Running Unit Test and Widget Test

```bash
# all test
flutter test
# specific file
flutter test test/presentation/features/home/home_screen_test.dart
```

## Running Integration Test or end-to-end test

```bash
# specific flavor
flutter test integration_test/app_test.dart  --flavor fake
```
