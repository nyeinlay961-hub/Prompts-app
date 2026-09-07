# Invokersyny Prompt Builder - Android APK Assembly Guide

This folder contains the complete Flutter Android codebase for **Invokersyny Prompt Builder**.

## Quick Build Instructions

### Prerequisites
- Install Flutter SDK (>= 3.0.0): https://docs.flutter.dev/get-started/install
- Android Studio / Android SDK with command-line tools

### Assemble Android APK
Run the following commands in this directory:

```bash
# 1. Fetch dependencies
flutter pub get

# 2. Assemble release APK
flutter build apk --release
```

Your generated APK will be at:
`build/app/outputs/flutter-apk/app-release.apk`

To install it directly to an attached Android phone:
```bash
flutter install
# or:
adb install -r build/app/outputs/flutter-apk/app-release.apk
```
