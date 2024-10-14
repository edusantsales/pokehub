flutter build appbundle --obfuscate --split-debug-info=./android/ --release -t lib/main.dart
flutter build apk --obfuscate --split-debug-info=./android/ --release -t lib/main.dart
flutter build ios --obfuscate --split-debug-info=./ios/ --release -t lib/main.dart