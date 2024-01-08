# Website review all universities in Viet Nam 🥰

[<img src="assets/images/i_home_background.png">](https://rankyouruni.com/)

# Website 💻

[<img src="assets/images/i_home_logo.png"  style="width:300px">](https://rankyouruni.com/)

[Rank Your UNi](https://rankyouruni.com/)



## Technical 📡

- [Dependencies injection](https://pub.dev/packages/injectable)
- [State management Bloc/Cubit](https://pub.dev/packages/flutter_bloc)
- [Flavor development/product](https://medium.com/@animeshjain/build-flavors-in-flutter-android-and-ios-with-different-firebase-projects-per-flavor-27c5c5dac10b)
- [Internationalizing i18n](https://docs.flutter.dev/development/accessibility-and-localization/internationalization)

## Architect 🌴

## Note 🗒️
There are 2 different type of bloc we can use. I want to choose to use the different bloc for different purpose:

- for global bloc: use Bloc
- for local bloc: use Cubit

Why? Because global state change can be from anywhere in the app, any screen, so it makes sense to trigger an event from 1 screen, and state is updated in all related screens in the app.
However, as for local bloc, the event and state are in the same screen, so it really doesn’t matter if the trigger is an event or a function call. Therefore, to simplify the code, I think cubit is better choice.

## Setup flavor ⚒️

- dev
  - run args: -d chrome --web-browser-flag "--disable-web-security" --web-port=8080
  - build flavor: dev
  - file: main_dev.dart
- product
  - run args: -d chrome --web-browser-flag "--disable-web-security" --web-port=8080
  - build flavor: prod
  - file: main_prod.dart

## Build 📁

```bash
  flutter build android flavor dev -t lib/main_dev.dart
  flutter gen-l10n
  flutter packages pub run build_runner build
  flutter run -d web-server --web-port 8080 --web-hostname 0.0.0.0 -t lib/main_prod.dart
```

## Deploy ✈️

### Admin

- add below code in **firebase.json**

```bash
  "site": "admin-rankyouruni",
```

Example

```bash
  {
    "hosting": {
      "site": "admin-rankyouruni",
      "public": "build/web",
      "ignore": [
          "firebase.json",
          "**/.*",
          "**/node_modules/**"
        ],
      "rewrites": [
        {
          "source": "**",
          "destination": "/index.html"
        }
      ]
    }
  }
```

- run cmd

```bash
  flutter build web --release -t lib/main_admin_prod.dart
  firebase deploy --only hosting:admin-rankyouruni
```

### Normal

```bash
  flutter build web --release -t lib/main_prod.dart
  firebase deploy --only hosting:rankyouruni
```