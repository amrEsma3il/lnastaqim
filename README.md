# Lnastaqim

A comprehensive, modern open-source Islamic application built with Flutter, designed to facilitate daily Islamic practices including Quran reading, recitation listening, prayer times, hadith, azkar, live radio streaming, and utility tools.

[![CI Status](https://github.com/amrEsma3il/lnastaqim/actions/workflows/pr_checks.yml/badge.svg)](https://github.com/amrEsma3il/lnastaqim/actions)
[![Flutter Version](https://img.shields.io/badge/Flutter-3.29.2-02569B?logo=flutter)](https://flutter.dev)
[![Dart Version](https://img.shields.io/badge/Dart-3.7.2-0175C2?logo=dart)](https://dart.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-green.svg)](#supported-platforms)
[![Architecture](https://img.shields.io/badge/Architecture-Clean%20%2F%20Feature--First-orange.svg)](#architecture)

---

## Features

- **Noble Quran:** Read the Holy Quran in authentic Uthmanic script with integrated Tafseer, word meanings, and instant ayah search.
- **Audio Recitations:** Listen to recitations from over 100 renowned reciters with background playback, lock screen controls, and notification tray integration.
- **Prayer Times:** Accurate prayer time calculation based on geographical location, with timely adhan alerts and notifications.
- **Qibla Compass:** Digital compass to determine Qibla direction from anywhere in the world.
- **Azkar and Digital Sibha:** Morning, evening, and situational supplications paired with an interactive digital Tasbeeh counter.
- **Prophetic Hadiths:** Categorized authentic hadith collections with bookmarking and sharing capabilities.
- **Live Quran Radio:** 24/7 streaming for international and regional Quran broadcast stations.
- **Ibtihalat Player:** Dedicated audio player for Islamic chants and historical supplications.
- **Mosque Finder:** Locate nearby mosques through Google Maps integration.
- **Hijri Calendar:** Comprehensive Hijri and Gregorian calendar synchronized with major Islamic events.

---

## Architecture and Tech Stack

The application follows a Feature-First Clean Architecture pattern:

```text
lib/
├── config/                 # Routing, themes, and localization settings
├── core/                   # Shared utilities, constants, and global services
│   ├── constants/          # Application colors, asset keys, and constants
│   ├── local_database/     # Hive database setup and TypeAdapters
│   ├── utilits/services/   # Audio, notification, location, and background services
│   └── errors/             # Network exceptions and error handling
├── features/               # Feature-first modular components (33 features)
│   ├── quran/              # Quran reading, fonts, and search
│   ├── quran_sound_player/ # Quran surah audio player
│   ├── paryer_times/       # Prayer times calculation and notifications
│   ├── qibla/              # Qibla compass
│   ├── azkar_with_sib7a/   # Azkar collections and digital sibha
│   ├── 7adis/              # Hadith collections
│   ├── radio_stream_channels/# Live radio streaming
│   └── ...
├── dependancy_injection.dart # Service locator registration using GetIt
└── main.dart               # Entry point, initialization, and notification handlers
```

### Core Technologies

- **Framework:** Flutter SDK (`>= 3.29.0`) & Dart SDK (`>= 3.7.0`)
- **State Management:** `flutter_bloc` (Bloc & Cubit)
- **Local Database:** `hive_flutter` & `shared_preferences`
- **Audio Engine:** `just_audio`, `audio_service`, `radio_player`
- **Networking:** `dio` & `retrofit`
- **Sensors and Geolocation:** `geolocator`, `adhan`, `flutter_compass`
- **Background and Notifications:** `flutter_local_notifications` & `workmanager`
- **Dependency Injection:** `get_it`

---

## Getting Started

### Prerequisites

- Flutter SDK (`>= 3.29.0`)
- Dart SDK (`>= 3.7.0`)
- Java Development Kit (JDK 17)
- Android Studio or VS Code with Flutter and Dart extensions

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/amrEsma3il/lnastaqim.git
   cd lnastaqim
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run code generation (for Hive and Freezed models):**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Run the application:**
   - **Development Flavor:**
     ```bash
     flutter run --flavor lnastaqim_dev -t lib/main_lnastaqim_dev.dart
     ```
   - **Production Flavor:**
     ```bash
     flutter run --flavor lnastaqim_prod -t lib/main_lnastaqim_prod.dart
     ```

---

## Testing and Analysis

Run the following commands locally before submitting any changes:

```bash
# Verify code formatting
dart format --output=none --set-exit-if-changed .

# Run static code analysis
flutter analyze

# Execute test suite
flutter test
```

---

## Automation and CI/CD

Continuous integration and continuous deployment are managed through GitHub Actions:

- **`pr_checks.yml`:** Automatically executes on pull requests to validate formatting, static analysis, unit tests, and development build integrity.
- **`flutter_fastlane_firebase_distribution.yml`:** Triggered on releases or pushes to the main branch to build production artifacts, publish GitHub releases, and distribute builds through Fastlane and Firebase App Distribution.

---

## Contributing

Contributions are welcome. Please read [CONTRIBUTING.md](CONTRIBUTING.md) for branch conventions, commit standards, and pull request guidelines.

---

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
