# Changelog

All notable changes to the Lnastaqim project are documented in this file.

The format is based on Keep a Changelog, and this project adheres to Semantic Versioning.

---

## [1.1.3] - 2026-09-03
### Added
- GitHub Actions CI/CD workflows for automated pull request checks, formatting, analysis, and build validation.
- Pull request and issue templates (Bug Report, Feature Request).
- Repository governance documentation: CONTRIBUTING.md, LICENSE, SECURITY.md, and upgraded README.md.
- Stricter linter configurations in analysis_options.yaml for consistent code quality.

### Changed
- Refactored CD workflow to use Fastlane with automated caching and single-pass flavor builds.
- Normalized font asset paths in pubspec.yaml for cross-platform compatibility.
- Resolved duplicate SurahPlayerRepo dependency registration in dependancy_injection.dart.

### Fixed
- Fixed sound player notification icon attributes compatibility with modern Android notifications.
- Fixed Quran and Hadith local storage handling.

---

## [1.0.0] - 2024-2025
### Added
- Complete Quran reading module with page navigation, bookmarking, and tafseer.
- Audio recitation player for 100+ reciters with background playback support.
- Azkar, Hadith library, Digital Sibha, and daily inspirations.
- Accurate prayer times and Qibla compass based on geolocation.
- Live Islamic Radio streaming channels.
- Ibtihalat and chants player.
- Mosque finder via Google Maps.
