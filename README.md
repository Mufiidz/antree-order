# Antree Order (2/3)
Sebuah Web yang akan membuat dan mengatur antrean pemesanan dari sisi merchant. Website ini dibuat dengan menggunakan [Flutter](https://flutter.dev/).

## Library
1. [BLoc](https://pub.dev/packages/flutter_bloc) for State Management
2. [Dio](https://pub.dev/packages/dio) for HTTP Client
3. [Get_it](https://pub.dev/packages/get_it) for Dependency Injection
4. [Auto Route](https://pub.dev/packages/auto_route) for Routing 2.0 
5. Used Material Components, ViewModel, and any more libraries.

## Database
- [Antree Order API](https://github.com/Mufiidz/Antree-Order-API)

## Feature
- Login
- Register

## Screenshoots
![Login](/screenshoots/login.jpg)
![Register](/screenshoots/regis.jpg)

## Note
Dont forget to run generator. Use the [watch] flag to watch the files system for edits and rebuild as necessary.
```dart
flutter packages pub run build_runner watch
```
if you want the generator to run one time and exits use
```dart
flutter packages pub run build_runner build
```

## Next Update
- Home and other main feature
- Deploy to public