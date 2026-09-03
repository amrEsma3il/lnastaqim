# Lnastaqim

A production-grade Islamic mobile platform built with Flutter, providing Quranic reading and audio streaming, astronomical prayer calculations, hadith indexes, and location-based religious utilities.

[![CI Status](https://img.shields.io/github/actions/workflow/status/amrEsma3il/lnastaqim/pr_checks.yml?branch=main&label=CI&style=flat-square)](https://github.com/amrEsma3il/lnastaqim/actions)
[![Quality Gate](https://img.shields.io/badge/SonarQube-Quality%20Gate-005b96?style=flat-square)](sonar-project.properties)
[![Flutter](https://img.shields.io/badge/Flutter-3.29.2-02569B?style=flat-square&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.7.2-0175C2?style=flat-square&logo=dart&logoColor=white)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-blue.svg?style=flat-square)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-4c1?style=flat-square)](#supported-platforms)

---

## Technical Overview

Lnastaqim is engineered using a modular, Feature-First Clean Architecture designed for high concurrency and robust offline operation. State orchestration is governed by BLoC/Cubit, data persistence is powered by Hive key-value stores with custom binary adapters, and audio playback executes via isolated background services with lock-screen and notification controls.

---

## Core Capabilities

| Domain | Implementation | Key Capabilities |
| :--- | :--- | :--- |
| **Quran & Tafseer** | `lib/features/quran` | Uthmanic Hafs script rendering, downloadable font bundles, Ayah search engine, word meanings, and bookmark persistence. |
| **Audio Services** | `lib/features/quran_sound_player`<br>`lib/features/radio_stream_channels`<br>`lib/features/ibtihal` | Isolated background audio pipeline supporting 100+ reciters, live streaming radios, Ibtihalat playback, and media notifications. |
| **Prayer Times & Qibla** | `lib/features/paryer_times`<br>`lib/features/qibla` | Astronomical calculations via Adhan engine, GPS coordinates resolution, digital compass vector tracking, and local Azan alerts. |
| **Hadith & Athkar** | `lib/features/7adis`<br>`lib/features/azkar_with_sib7a` | Indexed authentic collections, digital Tasbeeh counter, local favorites caching, and category filtering. |
| **Location Utilities** | `lib/features/community` | Proximity-based mosque discovery leveraging Google Maps and Geolocation APIs. |
| **Calendar & Sync** | `lib/features/calender` | Dual Hijri-Gregorian synchronization with lunar event tracking. |

---

## Technology Stack

| Category | Library / Dependency | Role |
| :--- | :--- | :--- |
| **State Management** | `flutter_bloc` `^9.1.0` | Event-driven state isolation and reactive state management. |
| **Service Locator** | `get_it` `^8.0.3` | Decoupled dependency injection across repository and domain layers. |
| **Local Persistence** | `hive_flutter` `^1.1.0` | High-performance NoSQL binary storage with custom TypeAdapters. |
| **Audio Engine** | `just_audio` `^0.10.3`<br>`audio_service` `^0.18.18` | Foreground and background audio playback with OS media controls. |
| **Network & REST** | `dio` `^5.4.0`<br>`retrofit` | Type-safe HTTP networking with interceptors and error decoding. |
| **Geolocation & Astronomy**| `geolocator` `^13.0.4`<br>`adhan` `^2.0.0+1` | Coordinate resolution and astronomical prayer schedule synthesis. |
| **Notifications** | `flutter_local_notifications` `^19.1.0` | Precise scheduling of Azan and situational alerts. |
| **Background Execution** | `workmanager` | Periodic headless background synchronization tasks. |

---

## Architecture and Directory Layout

The codebase enforces strict modular encapsulation:

```text
lib/
├── config/                 # Routing, theme tokens, and localization manifests
├── core/                   # Shared infrastructure and utilities
│   ├── constants/          # Static themes, palette mappings, and keys
│   ├── errors/             # Network exceptions and failure representations
│   ├── local_database/     # Hive box managers and binary TypeAdapters
│   └── utilits/services/   # Audio, notification, location, and background daemons
├── features/               # Domain-driven modular features (33 modules)
│   ├── 7adis/              # Prophetic hadith indexing and search
│   ├── azkar_with_sib7a/   # Supplication modules and digital counter
│   ├── paryer_times/       # Astronomical prayer timing logic
│   ├── qibla/              # Compass sensor integration
│   ├── quran/              # Holy Quran reading canvas, fonts, and tafseer
│   ├── quran_sound_player/ # Reciter-based Surah playback engine
│   └── radio_stream_channels/# HLS/AAC live radio streaming
├── dependancy_injection.dart # Service locator graph definition
└── main.dart               # App entrypoint, engine initialization, isolate routing
```

---

## Getting Started

### Prerequisites

- **Flutter SDK:** `3.29.2` (Stable)
- **Dart SDK:** `^3.7.2`
- **JDK:** Version 17
- **Platform Toolchains:** Android SDK Build-Tools 34+, Xcode 15+ (for iOS)

### Installation & Initialization

1. Clone the repository:
   ```bash
   git clone https://github.com/amrEsma3il/lnastaqim.git
   cd lnastaqim
   ```

2. Fetch project dependencies:
   ```bash
   flutter pub get
   ```

3. Execute code generation for Hive adapters and Freezed models:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

---

## Build Flavors and Execution

The project provides dedicated application flavors for development and production environments:

| Flavor | Target File | Application ID | Purpose |
| :--- | :--- | :--- | :--- |
| `lnastaqim_dev` | `lib/main_lnastaqim_dev.dart` | `com.islam.lnastaqim.dev` | Local debugging, staging APIs, unminified tracing. |
| `lnastaqim_prod` | `lib/main_lnastaqim_prod.dart` | `com.islam.lnastaqim` | Production release, Crashlytics telemetry, release optimizations. |

### Run Commands

- **Development Flavor:**
  ```bash
  flutter run --flavor lnastaqim_dev -t lib/main_lnastaqim_dev.dart
  ```

- **Production Flavor:**
  ```bash
  flutter run --flavor lnastaqim_prod -t lib/main_lnastaqim_prod.dart
  ```

### Build Commands

- **Android APK (Production):**
  ```bash
  flutter build apk --flavor lnastaqim_prod -t lib/main_lnastaqim_prod.dart --release --no-tree-shake-icons
  ```

- **Android App Bundle (Production):**
  ```bash
  flutter build appbundle --flavor lnastaqim_prod -t lib/main_lnastaqim_prod.dart --release
  ```

---

## Quality Assurance and CI/CD

Continuous integration pipelines enforce high code standards and deterministic deployments via GitHub Actions:

- **Quality Validation (`pr_checks.yml`):**
  Executes on all pull requests targeting `main` and `dev`:
  ```bash
  # Format verification
  dart format --output=none --set-exit-if-changed .

  # Static code analysis
  flutter analyze --no-fatal-infos

  # Test suite execution
  flutter test
  ```

- **Code Security & Metrics (`sonar.yml`):**
  Generates LCOV coverage metrics and runs static security audits via SonarQube.
  ```bash
  flutter test --coverage
  ```

- **Deployment Pipeline (`flutter_fastlane_firebase_distribution.yml`):**
  Compiles production artifacts, creates tagged GitHub Releases, and deploys build artifacts through Fastlane and Firebase App Distribution.

---

## Contribution Standards

Contributions must comply with our development standards:
- Follow the [Conventional Commits](https://www.conventionalcommits.org/) specification (`feat:`, `fix:`, `refactor:`, `perf:`).
- Verify all linting checks and tests pass locally before opening a pull request.
- Refer to [CONTRIBUTING.md](CONTRIBUTING.md) for full branch policies and review procedures.

---

## License

This project is licensed under the MIT License. Refer to the [LICENSE](LICENSE) file for details.
