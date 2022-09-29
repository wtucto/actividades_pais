# actividades_pais

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


flutter run --no-sound-null-safety
flutter build apk --release --no-sound-null-safety



### ERRORES Y POSIBLES SOLUCIONES


## ERROR 1
Parse Issue (Xcode): Module 'fluttertoast' not found
/Users/egarciti/Documents/Projects/App/Git/actividades_pais/ios/Runner/GeneratedPluginRegistrant.m:23:8


Could not build the application for the simulator.
Error launching application on iPhone 11.

## SOLUCION 1

iOS -> 
flutter clean
flutter pub get
pod repo update
pod install