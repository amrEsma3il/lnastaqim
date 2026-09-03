# PROJECT FORENSIC AUDIT — Lnastaqim (لنستقيم)

**Audit date:** 2026-08-23  
**Repository:** `/Users/amresmail/work/lnastaqim`  
**Scope:** Entire repository, including Flutter source, bundled databases, assets, Android/iOS/web/desktop configuration, Firebase configuration, CI/Fastlane, dependencies, tests, and Git-visible metadata.  
**Method:** Static, read-only forensic review; asset metadata/hash/type inspection; selective visual inspection; repository-wide string/URL/license/secret searches; official Google Play policy cross-check. No build, dependency installation, package upgrade, source modification, or destructive operation was performed.

> This is an engineering and compliance risk assessment, not legal advice. “No license found” means no license or authorization evidence was found in this repository; it does not prove that no external right exists. Such rights are marked **NEEDS EXTERNAL VERIFICATION**.

## Executive conclusion

**Most likely rejection cause — HIGH confidence:** the submitted app presents and redistributes a large catalog of third-party religious media/content without repository-visible provenance or authorization, while its in-app copyright statement claims that all text, audio, images, and design are owned/reserved by the app. The strongest repository-confirmed indicator is the bundled production alarm audio `ahmed_eltrabolsy_fajr.mp3`, whose embedded metadata identifies `www.islamweb.net` as artist/comment and contains an `©2013` album tag. The app also streams named performers from Archive.org, Matb3aa, QuranGo/MP3Quran and other services, hotlinks images from Google image caches, Pinterest, news publishers, YouTube, government and third-party sites, downloads another GitHub author's hadith datasets, and ships classical tafsir/Quran translations/fonts with no provenance registry.

This does **not** establish infringement. It establishes a severe inability to demonstrate rights, plus a misleading ownership assertion. Google Play could reasonably classify the submitted presentation under **Intellectual Property (primarily copyright), with related misrepresentation/impersonation risk**. Trademark risk is possible where service names/logos or recognizable identities are used, but the repository evidence is stronger for copyright/content-rights and misleading ownership than for a specific trademark claim.

There are independent Play submission blockers: background location is declared without evidence of a core background-location feature or prominent disclosure; broad media/storage, exact-alarm and full-screen-intent permissions are declared; a foreground service uses the placeholder explanation “To demonstrate…”; cleartext traffic is globally enabled; the privacy statement contradicts Firebase Analytics/Crashlytics configuration and network/location behavior; and there is no repository store-listing package or externally hosted privacy-policy URL.

**Google Play rejection risk:** HIGH  
**Intellectual-property risk:** HIGH  
**Overall project health:** **29/100**  
**Recommended strategy:** **FIX legal/compliance blockers immediately, then PARTIAL REWRITE of the production shell, content-provider boundary, permission model, and media/background services.** The Quran/azkar/bookmark UI and domain models are salvageable after provenance validation.

---

# 1. Project Reconstruction

## Identity and toolchain

| Item | Repository evidence | Determination |
|---|---|---|
| Application name | `pubspec.yaml:1`; Android flavor resource; Arabic UI | Package/project `lnastaqim`; production label `lnastaqim`/`Lnastaqim`; displayed Arabic brand “لنستقيم” |
| Dart package description | `pubspec.yaml:2` | Islamic app providing prayer times, Quran recitation, and more |
| Android namespace | `android/app/build.gradle.kts:21` | `com.example.lnastaqim` (template-like namespace) |
| Android production application ID | `android/app/build.gradle.kts:38,59` | `com.islam.lnastaqim` |
| Android development ID | `android/app/build.gradle.kts:49-54` | `com.islam.lnastaqim.dev` |
| iOS production bundle ID | `ios/Runner.xcodeproj/project.pbxproj` | `com.islam.lnastaqim` |
| iOS development bundle ID | same | `com.islam.lnastaqim.dev` |
| Pubspec version/build | `pubspec.yaml:19` | `1.0.0+1` |
| Distribution version/build | `android/fastlane/Fastfile:8` | Fastlane overrides with `1.1.3+4`; the actual rejected artifact version is **NEEDS EXTERNAL VERIFICATION** |
| Flutter project revision | `.metadata` | Flutter revision `414564…`, stable; local installed SDK identifies as Flutter **3.35.0** at revision `b896255…` |
| CI Flutter version | `.github/workflows/flutter_fastlane_firebase_distribution.yml:24` | **3.29.2**, inconsistent with local project metadata/toolchain |
| Dart constraint | `pubspec.yaml:22` | `^3.7.2`; exact Dart version used for rejected build **NEEDS EXTERNAL VERIFICATION** |
| compileSdk / targetSdk | `android/app/build.gradle.kts:22,42` | Inherited from Flutter SDK, not pinned. With the currently installed Flutter 3.35 SDK, effective values require build-generated verification; rejected artifact values **NEEDS EXTERNAL VERIFICATION** |
| minSdk | `android/app/build.gradle.kts:41` | 23 |
| NDK | same, line 23 | `27.0.12077973` |
| Kotlin plugin | `android/settings.gradle.kts:22`; app dependency line 88 | Plugin 2.1.20, explicit stdlib 1.9.24 — version skew |
| Android Gradle Plugin | `android/settings.gradle.kts:17` | 8.7.0 |
| Gradle wrapper | `android/gradle/wrapper/gradle-wrapper.properties` | 8.10.2 |
| Java | Android compile options; CI | Java 17 target and CI JDK 17; auditor host JDK 25 is not production evidence |
| iOS deployment target | `ios/Podfile:2` vs Xcode project | Podfile 14.0; multiple project configs show 12.0, while generated build cache shows 14.0. Effective archive target is configuration-dependent |
| Swift | Xcode project | Swift 5.0 |
| Signing | Android build file | Release signing reads `key.properties` then selects release; keys absent from repository. Play App Signing and rejected certificate **NEEDS EXTERNAL VERIFICATION** |

As of the audit date, Google Play states that new apps and updates must target API 35, changing to API 36 on 2026-08-31 (extension may be available). The submitted AAB’s actual target must be checked in Play Console or with `apkanalyzer`; it is not inferable with legal certainty from `flutter.targetSdkVersion`. See [Google Play target API requirements](https://support.google.com/googleplay/android-developer/answer/11926878?hl=en).

## Architecture and infrastructure

- **Architecture:** feature-first folders with partial presentation/business-logic/data layering. In practice, large local Dart data files, Cubits, widgets, and global services are tightly coupled.
- **State management:** primarily `flutter_bloc` Cubits; also GetX navigation/global APIs, StatefulWidget local state, and static/global variables.
- **Dependency injection:** `get_it` exists in `lib/dependancy_injection.dart`, but `setup()` is not called and registers `SurahPlayerRepo` twice, which would throw if executed. Most dependencies are constructed directly.
- **Navigation:** GetX named routes. Two different pages register the same `AppRouteName.aboutUs`, creating ambiguous routing.
- **Networking:** `http`, Dio, `cached_network_image`, audio players, raw remote URLs, Nominatim reverse geocoding, GitHub raw content.
- **Storage:** Hive boxes for favorites, notes, bookmarks, notifications, reciter data; SharedPreferences for flags; downloaded JSON/audio/fonts in application documents storage.
- **Authentication/backend:** no user login or first-party business API. Firebase Core, Crashlytics package/configuration and native Firebase Analytics dependency are present.
- **Analytics/crash reporting:** native Firebase Analytics is explicitly linked; Crashlytics initialization exists but collection wiring is commented. Runtime collection behavior **NEEDS EXTERNAL VERIFICATION**.
- **Notifications/background:** local notifications, boot receivers, exact alarms, WorkManager from a Git `main` branch, media foreground services, full-screen intent declarations.
- **Native integrations:** location, compass, maps intent, local notifications, audio, deep links (`qr://muslim.lnastaqim`), sharing/screenshots, TTS.
- **Flavors:** `lnastaqim_dev` and `lnastaqim_prod`, each with Firebase files and native resources.
- **CI/CD:** GitHub Actions builds an unflavored release APK (likely inconsistent with product flavors), creates a GitHub release, then Fastlane builds the production flavor and distributes it to Firebase App Distribution. No Play upload lane is configured.
- **Tests:** one unchanged Flutter counter-template widget test that does not match this app; one empty/template iOS test; no unit/integration/E2E coverage.

## Entrypoints

- `lib/main.dart`: shared parameterized runner, not directly a valid zero-argument Flutter entrypoint for normal `flutter run/build`.
- `lib/main_lnastaqim_dev.dart`: initializes the shared runner with development Firebase options.
- `lib/main_lnastaqim_prod.dart`: initializes the shared runner with production Firebase options and is the intended production entrypoint, confirmed by `android/fastlane/Fastfile`.
- The CI command `flutter build apk --release` does not specify flavor or target; the later Fastlane command correctly specifies `--flavor lnastaqim_prod -t lib/main_lnastaqim_prod.dart`.

# 2. Complete Project Structure and Data Flow

```text
Project
├── lib/
│   ├── main.dart; main_lnastaqim_{dev,prod}.dart
│   ├── firebase/                 generated Firebase options
│   ├── config/                   routing, localization, theme
│   ├── core/
│   │   ├── constants/            paths, keys, colors, URLs
│   │   ├── local_database/       Quran, tafsir, azkar, radio, reciter datasets
│   │   ├── errors|data_state/    API result/error models
│   │   └── utilits/              notifications, location, audio, maps, widgets
│   └── features/                 Quran, audio, hadith, radio, prayer, qibla,
│                                azkar, sibha, notes, favorites, settings, etc.
├── assets/
│   ├── fonts/                    8 Arabic/Quran fonts
│   ├── images/                   app art, people, book art, UI images
│   ├── svgs/                     UI art, flags, 114 surah names
│   ├── sounds/                   four alarm/notification MP3s
│   └── json/animations/          three Lottie animations
├── android/                      flavors, manifests, resources, Gradle, Fastlane
├── ios/                          Xcode project, Firebase plist, CocoaPods
├── macos|windows|linux|web/      generated desktop/web targets
├── test/                         obsolete template test
├── .github/workflows/            GitHub release + Firebase distribution
└── README.md                     Arabic product feature description
```

Typical flow: UI widget → globally provided Cubit → repository or embedded Dart dataset/remote URL → Hive/SharedPreferences or audio/network client → Cubit state → widget. Several features bypass repositories and call static services/globals directly. Remote content trust is implicit: URL lists are compiled into Dart, downloaded without manifest/signature/provenance validation, then displayed or played.

# 3. Application Purpose, Users, Flows, and Business Model

The implementation confirms a broad Islamic companion application for Arabic-speaking Muslim users. Primary flows are: mandatory startup location and notification permission; prayer-time display; Quran reading by page/surah with dynamically downloaded page fonts; Quran audio streaming/downloading by named reciter; hadith-book JSON download and browsing; tafsir selection; azkar and digital tasbih; qibla compass; local reminders; live Quran/religious radio; ibtihal/tawashih streaming; notes/bookmarks/favorites; sharing rendered verses/hadith/azkar; finding nearby mosques through an external maps app; and donation via an Instapay link.

No ad SDK or in-app purchase implementation was found. Monetization is donation/support. No authentication is implemented. “Community,” “competitions,” and some library/onboarding/game folders are placeholders or shallow screens, despite broader claims in the privacy/about text.

# 4. Google Play Rejection Forensic Investigation

## Most likely concrete trigger set

1. **Bundled media visibly attributed to another service.** `assets/sounds/notification_and_alarms/ahmed_eltrabolsy_fajr.mp3` and its identical Android raw copies contain embedded metadata: artist/comment `www.islamweb.net` and album `©2013`. SHA-256 equality confirms the same bytes are shipped in asset and Android flavor/main copies. No Islamweb license or authorization exists in the repository.
2. **Blanket ownership claim conflicts with source evidence.** `lib/features/settings/views/screens/copy_right.dart:72-74` says all app code, text, audio, images and designs are reserved to Lnastaqim and cannot be distributed. This purports to cover the Islamweb-tagged audio, remotely sourced public-figure recordings/images, downloaded GitHub data, and classical translations/tafsir for which no chain of title is recorded.
3. **Systematic third-party redistribution.** `ibtihalat_data.dart` streams named performers from Archive.org and `matb3aa.com`; `radio_local_database.dart` embeds the MP3Quran/QuranGo catalog; `radio_json.dart` hotlinks images from Pinterest, Google image cache, YouTube, news publishers and government sites while streaming stations over many third-party endpoints; Quran audio uses `cdn.islamic.network`; hadith books are downloaded from `AhmedBaset/hadith-json`; 603 page fonts are downloaded from the developer’s separate GitHub assets repo with no upstream provenance.
4. **No provenance/permission package.** No project-level LICENSE, NOTICE, asset registry, source ledger, authorization letter, trademark permission, content-provider terms, or attribution screen was found.
5. **Identity ambiguity.** The namespace is still `com.example.lnastaqim`, Fastlane Appfile declares `com.example.lnastaqim`, while the actual production ID is `com.islam.lnastaqim`. This is not itself infringement but weakens ownership consistency. The app uses named reciters and external broadcaster content without an “unofficial/not affiliated” disclosure.

Google’s impersonation policy prohibits misleading users about connection to another developer/company/entity or app. See [Impersonation FAQs](https://support.google.com/googleplay/android-developer/answer/16341334?hl=en). The repository does not claim “official,” so **specific impersonation is not confirmed**; however, branded/recognizable content plus a blanket ownership claim creates misrepresentation risk.

## What cannot be proven from this repository

- The exact Play Console rejection email, cited policy clause, reviewer screenshot, complainant, store listing, uploaded screenshots/feature graphic, developer legal identity, and submitted AAB are absent: **NEEDS EXTERNAL VERIFICATION**.
- Whether the developer has off-repository licenses from Islamweb, reciters/estates, broadcasters, photographers, publishers, Quran/tafsir/translation owners, font foundries, GitHub dataset author, or API operators: **NEEDS EXTERNAL VERIFICATION**.
- Whether Archive.org availability or a public stream grants commercial app redistribution rights: **NEEDS EXTERNAL VERIFICATION**; availability alone is not permission.

# 5. Asset Forensic Audit

## High-risk/suspicious asset groups

| Asset / path | Type / used by | Likely source & ownership evidence | License evidence | Risk | Required action |
|---|---|---|---|---|---|
| `assets/sounds/.../ahmed_eltrabolsy_fajr.mp3` plus Android raw copies | 229.46s MP3; prayer/alarm notifications | Embedded tags name Islamweb and the reciter. No app-origin evidence | None found | **Confirmed provenance conflict / HIGH** | Remove from release unless written redistribution rights and performer/recording rights are documented; replace with commissioned/licensed recording; preserve license record |
| `ali_elmola.mp3` plus copies | 204.54s MP3 | Named file/tag suggests a third-party performer; exact origin unknown | None | HIGH | Identify recording/master/rightsholder and permission or replace; **NEEDS EXTERNAL VERIFICATION** |
| `salah_mohamed.mp3`, `salah_nabi.mp3` | short MP3 cues | No useful embedded ownership metadata | None | MEDIUM | Obtain creator/source records or replace with commissioned/original cues |
| `ibtihalat_data.dart` remote MP3 catalog | audio streamed in core player | Archive.org and Matb3aa URLs, named Mohammed Omran, Sayed Al-Naqshabandy, Nasser El-Din Tobar | None | HIGH | Suspend feature until each recording, composition/lyrics where applicable, performer and distribution right is verified |
| `quran_surah_player/surah_player_database.dart`, `reciter_entity.dart` | Quran recitation streams/downloads | MP3Quran/QuranGo/Islamic Network URLs and named reciters | None | HIGH | Obtain API/content terms and rightsholder authorization; do not assume religious recordings are public domain |
| `radio_local_database.dart` / `radio_json.dart` | 100+ radio streams | Comment states MP3Quran API; direct QuranGo and other station endpoints | None | HIGH | Establish provider agreements; verify rebroadcast/embedding rights and availability terms |
| Remote images in `radio_json.dart` | public-figure/station imagery | Hotlinked Pinterest, Google cache, YouTube, news sites, TVQuran, government domain | None | HIGH | Stop hotlinking; license each photo/logo or use original/authorized provider artwork |
| `reciter_1/100/101/102/110.png` | portraits in audio UI | Recognizable persons; no provenance metadata/registry | None | HIGH | Identify photographer/source, publicity/privacy and image rights; replace if undocumented |
| `bukari.png`, `muslim.png`, `abidawood.png`, `tarmzi.PNG`, etc. | hadith book tiles | Stylized book-title artwork, origin unknown | None | MEDIUM | Record creator/source; recreate as original text-only assets if rights cannot be shown |
| `quran_cover.png`, frames/backgrounds, Kaaba/Qibla imagery | Quran UI | visually polished artwork with no creator/source record | None | MEDIUM-HIGH | Reverse-source internally/external records; obtain license or commission replacements |
| `radio_feature_icon.svg`, `mosque_feature.svg` | feature icons | SVG comments explicitly say uploaded/generated by SVG Repo Mixer Tools | No copied license/attribution | MEDIUM | Identify exact SVG Repo pages/licenses and comply; replace if page/license cannot be proven |
| 114 `assets/svgs/surah_name/*.svg` plus banners/basmala | Quran presentation | coherent third-party-like calligraphic set; no source record | None | HIGH | Establish calligraphy/font/art rights; replace or license |
| eight `assets/fonts/*.ttf` | bundled Quran/Arabic typefaces | Binary font metadata identifies third parties: `QCF_BSML.ttf` and `UthmanicHafs_V20.ttf` identify King Fahd Glorious Quran Printing Complex (the latter embeds an EULA/conditions); `thuluth-decorated.ttf` identifies DecoType Thuluth/MS Office Edition and 1992–1998 copyright; `Al Mushaf Quran.ttf` identifies Amjad Hussain Alvi/Alvi Technologies; `ArabQuranIslamic140-7BG9A.ttf` says all rights reserved; Majeed contains third-party credits. Amiri embeds an OFL notice and Noto identifies Google | No corresponding license/notice files or compliance record bundled | **HIGH**; DecoType/MS Office and restricted-rights metadata particularly concerning | Add exact upstream license/version/source and demonstrate compliance for every font; remove/replace any font lacking provable redistribution/embedding permission |
| 603 downloaded `p2NNN.ttf` fonts | Quran page rendering | developer GitHub mirror, upstream source absent | None | HIGH | Document upstream foundry/license and redistribution rights; a self-owned mirror does not prove font ownership |
| local Quran/tafsir/translation Dart databases | reading/tafsir core | Quran Arabic text plus English translation and four classical tafsir datasets; compiler/editor/source absent | None | HIGH | Identify exact editions, translations, digitizers and licenses; validate text integrity |
| hadith book JSON from `AhmedBaset/hadith-json` | downloaded by HadithCubit | exact external GitHub author/repo is encoded | No license copied or attribution shown | HIGH | Check upstream license and dataset sources; obtain permission where required and provide attribution |
| Lottie JSON animations | loading/correct UI | no creator/source metadata | None | MEDIUM | Identify source and license or replace |
| app icon/splash | store and in-app identity | appears app-specific but creation records absent | None | LOW-MEDIUM | Retain design source/work-for-hire proof; reverse-image check before resubmission |

No GIF, M4A, MP4, PDF, packaged HTML content, or store screenshot/feature-graphic directory was found. Visual inspection does not determine legal ownership. All “appears original/copied” judgments beyond embedded/source metadata remain **NEEDS EXTERNAL VERIFICATION**.

# 6. Content Origin Investigation

| Content | Origin and implementation | Redistribution assessment |
|---|---|---|
| Quran text/English translation | large compiled Dart maps in `core/local_database/quran` | Locally republished; exact edition/license absent |
| Tafsir | compiled Baghawy, Ibn Kathir, Qurtubi, Tabari files | Locally republished digital editions; classical authorship does not automatically clear modern edition/digitization rights |
| Azkar | compiled `azkar_local_database.dart` | Origin/citation/license absent |
| Hadith | raw GitHub JSON download from `AhmedBaset/hadith-json` | Mirrors third-party repository content to device; no authorization evidence |
| Quran audio | direct CDN/MP3Quran/QuranGo URLs; download support | Streams and stores third-party recordings |
| Ibtihal | Archive.org/Matb3aa direct MP3 URLs | Streams recordings from public archives/websites; authorization unknown |
| Radio | QuranGo/MP3Quran and multiple stations | Aggregates/rebroadcasts streams; API comment shows catalog copied from MP3Quran |
| Images | bundled portraits/art and hotlinks | Displays third-party photos and publisher assets without source/license UX |
| Fonts | bundled TTF plus GitHub-downloaded page fonts | Redistributes and dynamically downloads fonts without recorded upstream rights |
| Location | Geolocator plus Nominatim request and external Google Maps intent | User coordinates leave device for Nominatim when compass screen resolves address; privacy policy says operations happen locally |

No HTML scraping parser/crawler was found. The risk is **catalog copying, hotlinking, direct streaming/downloading, and local republication**, not conventional DOM scraping.

# 7. Code-Level IP Risk

Repository searches found explicit references to GitHub user `AhmedBaset`, developer asset mirror `amrEsma3il/lnastaqim_assets`, Islamweb metadata, MP3Quran, QuranGo, Islamic Network, Archive.org, Matb3aa, Pinterest, Google/YouTube image hosts, news publishers, Nominatim/OpenStreetMap, named reciters and classical book authors. No attribution/legal notices covering those inputs were found.

The app does not use the words “official,” “authorized,” “affiliate,” or “sponsored” as a product claim. It does assert comprehensive ownership over third-party-looking material. Support/contact identity is a Gmail address and personal Instapay link; developer/company legal identity is not stated.

# 8. Impersonation / Misrepresentation Risk

- **No evidence of explicit “official” status:** therefore a confirmed impersonation violation cannot be claimed.
- **Possible false affiliation:** named public figures/reciters, live broadcaster/station content, and hotlinked broadcaster imagery can lead users to infer authorization when no “unofficial/not affiliated” disclosure is present.
- **Confirmed internal identity inconsistency:** namespace and Fastlane Appfile retain `com.example.lnastaqim`; production ID uses `com.islam.lnastaqim`; email/personal payment identity is not tied to a legal entity.
- **Confirmed misleading rights statement:** app claims ownership/control over all audio/images/text while shipped bytes identify another source.
- **Deep link:** custom scheme/host `qr://muslim.lnastaqim` has no verified HTTPS domain ownership. It is not Android App Links despite `autoVerify=true`.

# 9. Store Listing Forensics

No Play Store metadata, screenshots, feature graphics, title/short/full description package, privacy-policy URL, website, support listing, or prior submission record exists in the repository. The README and in-app copy are the only listing-like materials. Therefore listing-to-binary comparison is incomplete and **NEEDS EXTERNAL VERIFICATION**.

Internal claims already conflict with behavior:

- Privacy page: “no third-party sharing” and “all operations local”; code sends location to Nominatim, loads remote images/audio, initializes Firebase, and links Analytics.
- Privacy page advertises challenges/community and multiple donation systems; implementations are placeholder/limited and only Instapay is active.
- Copyright page claims all content rights; embedded/source evidence shows external content.
- README says more than 100 reciters and full control; catalog exists, but authorization and stream reliability are unverified.

# 10. Google Play Policy Risk Matrix

| Policy area | Finding / evidence | Severity | Likelihood | Root cause | Recommended fix |
|---|---|---:|---|---|---|
| Intellectual Property | External media/datasets/fonts/images; no rights registry | Critical | **High Probability** | Content acquired ad hoc | Remove/quarantine until rights are documented |
| Copyright | Islamweb-tagged bundled MP3; streamed recordings and copied datasets | Critical | **Confirmed Risk** (provenance), infringement itself unproven | No chain of title | Commission/license/attribute; retain written evidence |
| Trademark | External station/service/person branding and imagery | High | Possible Risk | No brand-use review | Obtain permission or use neutral text/original art |
| Impersonation | No “official” claim, but public figures/stations plus ownership statement | High | Possible Risk | Missing affiliation disclosure | Accurate operator identity and non-affiliation disclosure |
| Misrepresentation | Blanket rights claim contradicts source evidence; privacy claims contradict networking | Critical | High Probability | Boilerplate legal pages not behavior-mapped | Rewrite disclosures from verified facts |
| Deceptive behavior | No hidden installer/obfuscation/malware found | Low | No Evidence Found | — | Preserve transparent behavior |
| User Data | Precise location mandatory at startup; sent to Nominatim in compass flow | High | Confirmed Risk | Location treated as app prerequisite | Minimize, defer, disclose transmission |
| Privacy | Firebase Analytics linked while policy says no third-party sharing | Critical | High Probability | No data-flow inventory | Accurate policy and Data Safety form; disable unneeded SDK collection |
| Permissions | Background location, broad media/storage, exact alarms, full-screen intent | Critical | High Probability | Manifest accumulated sample permissions | Declare only core, demonstrably used permissions |
| Background activity | `specialUse` FGS with demo placeholder subtype; boot/exact alarm receivers | High | High Probability | Sample/plugin manifest copied into production | Valid FGS types/permissions/declarations and user controls |
| Malware/unwanted behavior | No malicious payload or dynamic code execution found | Low | No Evidence Found | — | Dependency/SBOM monitoring |
| Ads | No ad SDK found | Low | No Evidence Found | — | Ensure listing/Data Safety agrees |
| Device abuse | Full-screen/wake/turn-screen-on and exact alarm can be disruptive | High | Possible-High | Notification implementation overprivileged | Restrict to legitimate alarm flow or remove |
| Content policies | Religious content itself not a violation; accuracy/source governance absent | Medium | Possible | No editorial provenance | Source citations and correction process |
| Authentication | No auth, password, account deletion concern | Low | No Evidence Found | — | Do not claim accounts |
| Sensitive data | Location is sensitive; local notes/bookmarks unencrypted | Medium-High | Confirmed | No threat/privacy design | Minimize and protect local data |

Google requires prominent disclosure and approval for justified background location; privacy-policy text alone is insufficient. See [background location requirements](https://support.google.com/googleplay/android-developer/answer/9799150?hl=en). Full-screen intent is automatically eligible only for core alarm/call functions on Android 14+, and foreground-service types require declarations and appropriate permissions. See [sensitive permissions](https://support.google.com/googleplay/android-developer/answer/16558241?hl=en&rd=1) and [FGS requirements](https://support.google.com/googleplay/android-developer/answer/13392821?hl=en).

# 11. Root Cause Analysis

## RCA-1 — probable IP rejection

**Symptom:** Google Play reportedly rejected the app for suspected ownership/IP concerns.  
**Immediate cause:** The binary and runtime catalog contain externally attributable audio, recordings, images, fonts, datasets and public-figure content without submission-ready rights evidence.  
**Underlying cause:** Sources were copied, mirrored, hotlinked or referenced directly in code; the legal page applied a blanket app-ownership claim rather than attribution/licensing.  
**Root cause:** **No content acquisition governance:** no provenance ledger, license acceptance criteria, rightsholder approval workflow, asset review gate, or release evidence pack.  
**Evidence:** Islamweb MP3 tags; `AhmedBaset` raw GitHub URLs; MP3Quran API comment; Archive.org/Matb3aa URLs; SVG Repo comments; news/Pinterest/Google image URLs; absent license files.  
**Why Play could detect it:** binary/media fingerprinting, embedded ID3 metadata, recognizable artwork/voices/names, reviewer URL inspection, rights-holder complaint, or inconsistent listing/developer identity.  
**Business impact:** repeat rejection, takedown/strike, inability to prove ownership, potential rightsholder claims.  
**Technical impact:** core media/radio/hadith/font features cannot safely ship until providers are replaced or cleared.  
**Compliance impact:** likely IP policy scrutiny and possible misrepresentation/impersonation review.  
**Required fix:** quarantine every unverified content channel; obtain written rights or replace with commissioned/openly licensed content; correct ownership/attribution language; produce a rights dossier.  
**Preventive measure:** versioned asset/content manifest with source URL, author/rightsholder, license text, permission record, hash, allowed uses, expiry, and reviewer sign-off enforced in CI.

## RCA-2 — privacy/permissions rejection exposure

**Symptom:** App requests sensitive permissions before reaching core UI and declares background/full-screen/exact alarm capabilities.  
**Immediate cause:** Manifest requests exceed clearly evidenced runtime needs; policy copy is inaccurate.  
**Underlying cause:** sample/plugin configurations and planned features were retained in production.  
**Root cause:** No least-privilege permission/data-flow review tied to Play declarations.  
**Evidence:** background location; `USE_EXACT_ALARM` and `SCHEDULE_EXACT_ALARM`; full-screen intent; storage/media permissions; placeholder special-use FGS description; mandatory startup permission gates.  
**Why Play could detect it:** automated manifest scan, permissions declaration review, runtime review.  
**Required fix:** remove every unneeded declaration, redesign just-in-time permission UX, create prominent disclosure where genuinely required, reconcile Data Safety/privacy policy.

## RCA-3 — release identity/process failure

**Symptom:** IDs, versions, Flutter versions and CI build targets disagree.  
**Immediate cause:** template identifiers and parallel build paths remain.  
**Root cause:** No single reproducible, reviewed release configuration or compliance gate.  
**Evidence:** namespace/Appfile `com.example`; production ID `com.islam`; pubspec 1.0.0+1 versus Fastlane 1.1.3+4; CI Flutter 3.29.2 versus local 3.35; unflavored CI build.  
**Required fix:** one pinned production toolchain/artifact pipeline, verified package identity and signing record, automated manifest/version/content inventory.

# 12. Security Audit

## High and medium findings

- **Cleartext globally enabled:** `android:usesCleartextTraffic="true"`; many radio streams are HTTP. Traffic can be intercepted or substituted, including audio and remote imagery.
- **Overprivileged manifest:** background location, storage read/write, media read, notification policy access, both exact-alarm permissions, boot, wake lock, full-screen intent, broad FGS.
- **Placeholder foreground-service justification:** subtype says it exists “To demonstrate how to use foreground services,” which is not a production justification.
- **Unverified service classes:** `.core.StreamingCore` is declared but no corresponding Android class exists; explicit `dev.fluttercommunity.plus.androidalarmmanager.*` components are declared while that package is not in pubspec. Invocation can fail.
- **Firebase client identifiers exposed:** generated Firebase API keys/project IDs exist in source and platform files. Firebase client keys are commonly non-secret identifiers, but restrictions and backend Security Rules must be verified. Values are intentionally redacted here. **NEEDS EXTERNAL VERIFICATION**.
- **No private signing key/password found:** `key.properties` is excluded/absent. This is positive; signing custody remains external.
- **Remote code/data trust:** app downloads JSON/fonts/audio from mutable GitHub `main`/web URLs with no checksum, signature or schema limits. This permits supply-chain content substitution.
- **Font binary provenance:** multiple TTFs contain explicit third-party ownership, EULA or all-rights-reserved metadata. Some may permit distribution subject to conditions, but the repository contains no evidence that those conditions were assessed or met. `thuluth-decorated.ttf` identifies a DecoType “MS Office Edition,” making redistribution clearance especially urgent.
- **Git dependency on `workmanager` `main`:** non-immutable dependency source; lock has a resolved commit but future resolution is unstable.
- **Deep-link parsing:** force unwraps and `int.parse` on untrusted URI query parameters in `main.dart:500-501`; malformed links can crash.
- **Local data:** notes/bookmarks/favorites stored in unencrypted Hive. Sensitivity is moderate; no tokens/passwords are stored.
- **Logs:** 377 print/log calls may expose location, URLs, exceptions and behavior in debug/logcat; prayer repository logs computed times. No full token logging found.
- **iOS privacy crash risk:** `Info.plist` lacks location usage-description keys even though Geolocator requests location. iOS terminates apps that access protected resources without required purpose strings.

No SSL-certificate bypass, custom permissive TrustManager, private key, hardcoded password, bearer token, WebView JavaScript bridge, native dynamic library payload, adware, or hidden downloader was found.

# 13. Network & API Audit

| Endpoint/provider | Purpose / caller | Auth, request, storage, data | Third-party/content risk |
|---|---|---|---|
| `raw.githubusercontent.com/AhmedBaset/hadith-json/...` | Nine hadith books; `HadithCubit`/Dio | No auth; GET/download JSON to documents directory; no integrity check | External dataset redistribution; license absent |
| `raw.githubusercontent.com/amrEsma3il/lnastaqim_assets/main/fonts/...` | 603 Quran page fonts; FontDownloadPercentage | No auth; GET bytes to app storage; no hash/signature | Developer mirror but upstream font rights unknown; mutable branch |
| `cdn.islamic.network/quran/audio/...` | Quran recitation; audio Cubit | No auth; direct MP3 stream/download | Named performer/master rights and provider terms unrecorded |
| `backup.qurango.net`, `mp3quran.net` and many stations | Radio/audio catalogs | No auth; streams; background/media playback | Rebroadcast/API terms absent; availability not authorization |
| Archive.org and Matb3aa | Ibtihal player | No auth; direct MP3 stream | Recording/performer rights unknown |
| Remote image publishers | Radio list `CachedNetworkImage` | GET image, cache on device | Hotlinking, copyright, availability and user-IP disclosure risk |
| Nominatim OpenStreetMap | Reverse geocode in `compass_Screen.dart:59` | Sends precise latitude/longitude; no auth; response shown, not intentionally persisted | Personal data goes to third party; usage-policy/User-Agent compliance **NEEDS EXTERNAL VERIFICATION** |
| Firebase | initialization, Analytics native dependency, Crashlytics package | Client config embedded; telemetry behavior depends on SDK/config | Data Safety/privacy mismatch; project rules/restrictions external |
| Google Maps external intent | nearby mosque search | Coordinates/search handed to installed maps/browser | Third-party data handoff must be disclosed accurately |
| Instapay URL | donation | Opens external personal payment link | Identity/consumer disclosure risk; payment itself outside app |

There is no first-party REST/GraphQL backend and no API authentication layer. Failure handling is inconsistent; many endpoints are hardcoded and can disappear or change content.

# 14. Architecture Audit

Strengths: feature grouping, Cubit state separation in several flows, Hive typed models, production/dev entrypoint separation, and repository classes for some domains.

Major debt:

- 353,905 Dart lines, dominated by generated/embedded content: `quran_v2.dart` ~95.9k, `quran_local_database.dart` ~57.8k, tafsir files ~43–49k each.
- God files: `moshaf_view.dart` 1,494 lines, notification service 1,054, Sibha screen 1,051, Surah player Cubit 903, Ibtihal screen/Cubit ~875/838.
- Global mutable state (`prefs`, `position`, `initMain`, navigator key), static singleton factories, Get global navigation, and Cubits owning UI controllers.
- Three state/control approaches (Bloc, GetX, StatefulWidget) and largely unused/broken DI.
- Data, networking, storage, playback, notifications and UI concerns mixed in Cubits/widgets.
- Duplicate models/player stacks and duplicate datasets (`radio_local_database.dart` vs `radio_json.dart`; Quran audio implementations).
- Repository direction is inconsistent; UI imports concrete services and static datasets.

# 15. Flutter-Specific Audit

- `PrayersTimesCubit` starts a location stream and periodic timer; cancellation/close handling must be verified. `DateCubit` creates an unretained periodic timer, a confirmed lifecycle leak.
- Multiple audio Cubits call `.listen()` several times without retaining/canceling subscriptions; closing the player may not cancel every listener.
- `DeepLinkCubit` does not retain/cancel its broadcast subscription.
- Controllers are held in Cubits (`QuranCubit`, search and overlay Cubits) and many lack `close()` disposal.
- `HomeView` creates a `ScrollController`; disposal was not found.
- `NoteBottomSheet` creates a `TextEditingController` outside a State lifecycle; disposal not found.
- Several animation/list widgets correctly implement dispose; Layout disposes its PageController, showing inconsistent discipline.
- Async code frequently uses BuildContext/navigation after awaits without `context.mounted` checks.
- Background notification callbacks call Get navigation from a background entrypoint/isolate, where navigation context may not exist.
- Deep link force unwrap and parse are crashable.
- `main()` recursively retries initialization and uses `initMain` to skip portions, producing partial initialization states.
- Mandatory denial of notification/location sends the whole app to an error screen rather than permitting reduced functionality.

# 16. Performance Audit

Highest-impact bottlenecks:

1. Very large Dart constants increase compile size, snapshot size, startup memory and tree-shaking pressure.
2. Startup serially initializes Firebase/date/Hive/WorkManager, requests storage, obtains best-for-navigation location, requests notifications, and initializes notifications before `runApp`.
3. More than 30 global BlocProviders are created at the root; several are eager or attach media listeners.
4. 603 fonts are individually downloaded/loaded, with repeated HTTP calls and runtime font registration.
5. Large Quran search and JSON/data parsing occur in UI/Cubit isolates; no isolate strategy is evident.
6. Remote images have mixed sizes/unknown caching policies and some huge bundled images (e.g., 1200×1200 cover and 1452px art).
7. Duplicate native asset copies increase APK size; the same alarm audio is present in Flutter assets and three Android source sets.

# 17. Dependency Audit

“Status” below is repository status, not a live vulnerability assertion. Exact latest versions/CVEs and package maintenance must be rechecked immediately before resubmission.

| Package/version constraint | Purpose / used where | Status / risk | Recommendation |
|---|---|---|---|
| flutter_bloc 9.1.0 | primary Cubit state | Core, broadly used | Retain in salvage; standardize on it |
| get 4.6.1 | routing/global navigation | Mixed architecture/global context risk | Replace routing/global calls in partial rewrite |
| get_it 8.0.3 | intended DI | Broken/unused duplicate registration | Remove or implement one composition root after audit |
| dio 5.4.0 + http 1.3.0 | downloads/network | Duplicate clients; mutable content no integrity | One hardened client/provider layer |
| Hive 2.2.3 / hive_flutter 1.1.0 | local content/user state | Unencrypted, adapters globally registered | Retain for non-sensitive state; lifecycle/migrations/tests |
| shared_preferences 2.0.15 | flags | Old constraint relative to project SDK; plaintext | Use only non-sensitive preferences |
| Firebase Core 3.4 / Crashlytics 4.1 | telemetry | Disclosure/config mismatch | Decide collection policy; verify current compatible releases later |
| native Firebase Analytics via BoM 33.13 | analytics | Not declared in Dart but included natively | Remove if unnecessary or disclose/consent correctly |
| geolocator 13.0.4 / geocoding 4.0 | precise location | Sensitive data/permission risk | Foreground, just-in-time, coarse where possible |
| flutter_local_notifications 19.1 | alarms/media reminders | High manifest/policy surface | Redesign declarations and test Android 14–16 |
| workmanager Git `main` | background work | Unpinned source intent/supply-chain risk | Use reviewed immutable release/commit after separate upgrade plan |
| audioplayers 6.4, just_audio 0.10.3, audio_service 0.18.18, radio_player 1.6 | four audio stacks | Duplication and lifecycle complexity | Consolidate in partial rewrite |
| permission_handler 12.0 | runtime permission | Requests storage globally | Central least-privilege permission gateway |
| cached_network_image 3.4.1 | remote photos | Caches unlicensed/hotlinked images | Replace content and enforce trusted hosts |
| screenshot 3.0 / scroll_screenshot 0.0.4 | sharing | Captures third-party content into shareable derivative | Rights review; consolidate |
| adhan 2.0.0+1 / hijri 3.0 / intl | prayer/calendar | Local domain logic | Verify licenses/calculation correctness |
| flutter_compass 0.8 / google_maps_flutter 2.5.3 | qibla/maps | Maps plugin appears unnecessary for external intent; privacy surface | Remove unused dependencies only in implementation phase |
| retrofit >=4<5, dartz, fl_chart, flutter_tts, carousel and animation packages | utilities/UI | Several appear unused or lightly used | Confirm by dependency usage audit; prune later, not during this investigation |

The lockfile contains roughly 231 package entries. No `pub outdated` or online vulnerability scanner was run because the user prohibited installation/upgrades and the Flutter SDK attempted a forbidden cache write. Dependency freshness is **NEEDS EXTERNAL VERIFICATION**.

# 18. Android Audit

- Production ID is correct in the prod flavor, but namespace and `MainActivity.kt` remain under `com.example`; Fastlane Appfile also uses the example ID.
- Release signing config casts missing keystore values and assigns debug then release signing; effective result is release, but local builds fail without external `key.properties`.
- No `minifyEnabled`, `shrinkResources`, R8 rules, or explicit release hardening is configured.
- `targetSdk`/`compileSdk` are not pinned; verify the AAB meets current API requirements.
- Permissions are excessive as detailed above. Legacy `READ/WRITE_EXTERNAL_STORAGE` lack `maxSdkVersion`; Android media permissions are requested despite app-private storage use.
- Both `USE_EXACT_ALARM` and `SCHEDULE_EXACT_ALARM` are declared. The former is highly restricted; necessity is not demonstrated.
- `USE_FULL_SCREEN_INTENT`, `showWhenLocked`, `turnScreenOn` and alarm UI require a core alarm justification and Play declaration.
- FGS `specialUse` subtype is a demo placeholder. Media playback service permission exists but service/type mapping is inconsistent.
- Global cleartext traffic enables many HTTP radio endpoints.
- Custom deep link is exported and accepts unvalidated values; `autoVerify` does not validate a custom scheme.
- No network-security config or domain allowlist.
- Firebase production/dev files are committed; verify API restrictions and Security Rules.
- CI’s first APK build omits flavor/target. Fastlane Appfile package name is wrong. The repo has Firebase distribution only, not Play submission automation.

# 19. iOS Audit

- Podfile says iOS 14.0 while Xcode configurations retain 12.0; align before a real archive.
- `Info.plist` has no `NSLocationWhenInUseUsageDescription`/location purpose strings despite mandatory location access: release crash/review blocker.
- No notification purpose string is needed on iOS, but runtime permission UX still needs review.
- Bundle IDs are configured for prod/dev; no explicit development team is visible in reviewed settings, so signing is external.
- No associated domains/entitlements were found for verified universal links; custom Android deep link has no equivalent documented iOS URL scheme.
- Firebase plist is committed. Treat keys as client config, restrict services, and verify telemetry disclosure.
- Landscape orientations remain allowed in Info.plist while Flutter forces portrait, a configuration mismatch.
- No iOS privacy manifest authored by the app was found; current SDK/API required-reason status is **NEEDS EXTERNAL VERIFICATION**.

# 20. Data & Privacy Audit

| Data | Source/purpose | Storage/transmission/third party | Risk |
|---|---|---|---|
| Precise location | device; prayer time, qibla, mosque search/address | global memory; Nominatim request; external maps intent | High; mandatory startup and inaccurate disclosure |
| Device/OS telemetry | Firebase/DeviceInfo potential; performance/crash claims | Firebase/native SDK behavior **NEEDS EXTERNAL VERIFICATION** | High disclosure mismatch |
| Notes | user-created Quran notes | local Hive, unencrypted; no intentional server transfer | Medium |
| Favorites/bookmarks/memorized verses | user actions | local Hive | Low-Medium |
| Notification preferences/schedules | user choices and prayer/azkar timing | Hive/SharedPreferences and OS notification scheduler | Medium |
| Downloaded hadith/audio/fonts | user feature use | app documents/cache; providers see IP/device request metadata | Medium content/privacy risk |
| Donation navigation | user taps support | Instapay receives interaction/payment data | External processor disclosure needed |
| Shared screenshots/text | user-selected content | handed to OS share targets | User-directed, but content-rights risk |

Retention/deletion controls are not documented. There is no account or server-side deletion flow. The in-app policy is not sufficient as a Play listing policy URL and is materially inaccurate. Data Safety form, Firebase console settings, Nominatim/provider privacy terms and actual network captures are **NEEDS EXTERNAL VERIFICATION**.

# 21. Testing Audit

There are effectively **zero relevant automated tests**. `test/widget_test.dart` expects the default counter UI and will fail against Lnastaqim. No unit, integration, E2E, golden, API contract, storage migration, notification/alarm, permission, deep-link, audio, offline, localization, accessibility, or release-smoke tests were found.

Pre-resubmission minimum: production-flavor launch tests; permission-denial/reduced-mode tests; Android 13–16 exact alarm/FGS/full-screen tests; offline and bad-content tests; deep-link fuzz tests; iOS location launch; Quran/hadith integrity fixtures; audio lifecycle/background controls; privacy network capture; store AAB manifest scan; regression tests for bookmarks/notes/favorites.

# 22. Bug Discovery

| ID | Bug / location | Evidence | Severity | Root cause | Fix direction |
|---|---|---|---:|---|---|
| B01 | iOS location access termination | `ios/Runner/Info.plist` lacks purpose key; startup requests location | Critical | Native privacy config omitted | Add accurate usage descriptions during implementation |
| B02 | Deep-link crash | `main.dart:500-501` force unwrap + `int.parse` | High | Untrusted input not validated | Typed parser/range checks |
| B03 | DateCubit perpetual timer | `date_cubit.dart:13` unretained `Timer.periodic` | High | No lifecycle ownership | Retain/cancel in `close()` |
| B04 | Location stream leak | `prayers_times_cubit.dart:39` listen result not retained | High | Subscription not owned | Cancel on close |
| B05 | Audio subscription leaks | Ibtihal/Surah/Radio/Audio Cubits multiple `.listen()` | High | Event subscriptions not retained | Aggregate/cancel and single audio service |
| B06 | Broken DI if invoked | `dependancy_injection.dart` registers `SurahPlayerRepo` twice | High | Copy/paste composition | One registration; DI test |
| B07 | Ambiguous About route | router registers `AppRouteName.aboutUs` twice | Medium-High | Duplicate route table entry | Unique route IDs |
| B08 | Missing native service class | manifest `.core.StreamingCore` absent | High when service resolved | Stale manifest entry | Remove or implement correctly |
| B09 | AlarmManager components without dependency | manifest references `dev.fluttercommunity.plus.androidalarmmanager.*`; package absent | High when invoked | Stale sample config | Remove/replace after behavior audit |
| B10 | Background callback navigation | background notification callback calls Get routes | High | UI navigation from background isolate | Persist intent and route on foreground resume |
| B11 | App unusable if permissions denied | startup returns ErrorApp for location/notification denial | High | Optional features made global prerequisites | Graceful reduced mode |
| B12 | CI build ambiguity/failure | workflow unflavored `flutter build apk --release` with flavors and parameterized main | High | Two release paths | Single explicit prod build |
| B13 | Fastlane Play identity wrong | `android/fastlane/Appfile` says `com.example.lnastaqim` | High for supply lane | Template residue | Correct after ownership verification |
| B14 | DI/UI controllers not disposed | multiple Cubits/controllers listed in §15 | Medium | Ownership boundaries unclear | Lifecycle tests and close methods |
| B15 | HTTP streams fail/intercept | cleartext sources + global cleartext | Medium-High | Legacy endpoints | HTTPS trusted providers only |
| B16 | Retry produces partial initialization | recursive shared `main()` with `initMain` | Medium-High | Startup used as retry state machine | Explicit bootstrap state machine |
| B17 | Privacy policy false in runtime | remote/Firebase flows contradict local-only text | Critical compliance bug | Legal copy disconnected from code | Generate disclosure from data inventory |
| B18 | Template test fails | counter expectations absent | Medium | Test never adapted | Replace with real launch test |

Fix directions are documented only; no fix was applied.

# 23. Feature Inventory

| Feature | Entry/main files | APIs/storage/dependencies | Quality/issues |
|---|---|---|---|
| Quran reader/index/search | `features/quran`, local Quran DB | local Dart data, dynamic fonts, Hive state | Feature-rich; giant files, font provenance, lifecycle/performance risk |
| Tafsir | `features/tafaseer`, four local datasets | local data | Provenance absent; huge compile footprint |
| Quran audio/download | two Quran sound feature trees | Islamic Network/MP3Quran, Hive/audio players | Duplicated stacks; content rights and lifecycle risk |
| Hadith books | `features/7adis` | GitHub JSON, Dio, documents storage | External license absent; repeated download code |
| Azkar | `azkar_with_sib7a` | local dataset, Hive favorites | Source/citation absent |
| Sibha | `features/sibha` | local state/animation | Very large screen; no persistence tests |
| Prayer times | `paryer_times`, home | device location, Adhan | mandatory location; stream/timer leak |
| Qibla/address | `qibla` | compass, location, Nominatim | privacy disclosure and lifecycle risk |
| Mosque discovery | home feature | external Google Maps intent | external handoff, no in-app results |
| Radio | radio feature + two catalogs | QuranGo/MP3Quran/many HTTP streams | major provider/IP/reliability risk |
| Ibtihal/tawashih | `features/ibtihal` | Archive.org/Matb3aa, audio player, Hive | major recording-rights risk |
| Notifications/alarms | notification + core service | local notifications, exact alarm, WorkManager | policy-heavy, overprivileged, stale manifest |
| Notes/bookmarks/favorites | respective features | Hive | useful and salvageable; no migrations/tests/encryption |
| Sharing | `features/share` | screenshots/share sheet | derivative content/IP risk |
| Hijri calendar | `features/calender` | Hijri package/local state | basic, untested |
| Settings/legal/about | settings | static content/email | legal/privacy claims inaccurate |
| Support/donation | support | Instapay URL | personal identity/consumer disclosure needed |
| Community/competitions/library/help | feature shells/routes | mostly local/placeholders | claims exceed implementation |

# 24. Feature Opportunities

## Critical

- **Content provenance center:** user-visible sources/licenses/reciter/provider attribution, with internal signed manifest. Complexity high; dependency on legal/provider work; 4–8 engineering weeks plus external rights work.
- **Privacy/permission control center:** explain and toggle prayer, notification, downloads and telemetry; degraded mode without location. Complexity medium; 2–4 weeks.
- **Offline content integrity:** signed, versioned Quran/hadith/tafsir packages with checksums and edition metadata. Complexity high; 6–10 weeks.

## High Value

- Curated, authorized recitation/provider catalog with availability monitoring and fallback; high provider dependency, 4–8 weeks.
- Quran/tafsir edition/source selector and correction-report workflow; medium-high, 4–6 weeks.
- Backup/export/import for local notes/bookmarks without accounts; medium, 2–4 weeks.

## Medium

- Accessibility controls for Arabic typography, screen readers and audio controls; medium, 3–5 weeks.
- Download manager with size, Wi-Fi-only, checksum, license/source display and deletion; medium-high, 4–6 weeks.
- Prayer calculation-method and madhhab settings rather than hardcoded Egyptian/Shafi defaults; medium, 2–3 weeks.

## Nice to Have

- Editorially verified daily content with citations; ongoing content operations required.
- Cross-device sync only after a real privacy/security/account design; high complexity and not a resubmission priority.

# 25. Technical Debt Inventory

| Debt/location | Impact/future risk | Cost | Priority/solution |
|---|---|---:|---|
| No content rights registry, all content paths | Rejection/legal exposure | High external | P0 provenance gate |
| Inaccurate legal/privacy copy | Policy rejection/trust | Medium | P0 behavior-mapped disclosures |
| Overprivileged manifest | Play block/device abuse | Medium | P0 least privilege |
| Giant compiled databases | size/startup/maintainability | High | P1 versioned data packages |
| Multiple audio stacks | leaks/inconsistent background playback | High | P1 unified playback service |
| Global startup/permission state | brittle launch/retry | Medium-High | P1 bootstrap state machine |
| Mixed GetX/Bloc/local state | coupling/testability | High | P1 standardize Bloc + router |
| Broken unused DI | hidden runtime failure | Medium | P1 composition root |
| Mutable Git/raw-main dependencies | supply-chain risk | Medium | P0/P1 immutable artifacts |
| Zero meaningful tests | regression risk | High | P0 release smoke + critical flows |
| Toolchain/version identity drift | unreproducible artifacts | Medium | P0 pinned CI |
| HTTP/hotlinked endpoints | security/IP/reliability | High provider | P0 authorized HTTPS allowlist |
| Missing lifecycle cleanup | memory/battery/crashes | Medium | P1 ownership + tests |
| Template/stale native config | crashes/review flags | Medium | P0 manifest cleanup |
| Sparse documentation | key-person/compliance risk | Medium | P1 architecture/runbooks/SBOM |

# 26. Refactor vs Rewrite Decision

| Option | Advantages | Disadvantages / risk | Complexity/cost |
|---|---|---|---|
| A Continue as-is | Lowest immediate engineering cost | Repeat rejection likely; rights, privacy and lifecycle defects remain | Low now, extreme business risk |
| B Incremental refactor | Preserves features/data/UI | Hard to establish clean content/security boundaries around globals and duplicated media; prolonged hybrid state | Medium-high |
| C Partial rewrite | Keeps verified Quran/azkar/domain/UI components; replaces bootstrap, provider/media/data/permission/release layers | Requires migration and regression suite | **High but controlled; recommended** |
| D Full rewrite | Clean architecture and UX | Highest cost; loses working reader/state features; still does not solve content rights by itself | Very high |

**Recommendation:** First perform a non-code **content/legal FIX** and remove blockers from the intended release scope. Then execute **Option C, partial rewrite**. A full rewrite is not justified because local user-state models, several reader widgets, prayer calculation and feature concepts are salvageable. Incremental-only work is insufficient because content provenance, startup permissions, audio/background services and release configuration cross-cut the whole app.

# 27. Google Play Resubmission Readiness

## Must Fix Before Resubmission

1. Obtain and organize rights for every shipped/streamed/downloaded asset/content item or remove it from the release.
2. Remove/replace the Islamweb-tagged audio unless explicit written redistribution rights exist.
3. Suspend Ibtihal, radio, public-figure imagery, external Quran audio, hadith JSON and dynamic fonts until provider/rightsholder terms are documented.
4. Replace the blanket ownership statement with accurate ownership, licenses, attribution and non-affiliation language reviewed by qualified counsel.
5. Obtain the original rejection notice and map each cited element to a remediation record.
6. Reconcile package/developer identity, app name/icon, support email, legal entity and signing ownership.
7. Create an externally hosted, accessible, non-editable privacy policy linked in-app and in Play listing; make it match actual Firebase/location/provider flows.
8. Correct Data Safety and sensitive-permission declarations based on a runtime network/data inventory.
9. Remove background location unless a qualifying core background use is implemented and approved; current code evidence does not justify it.
10. Remove unjustified storage/media, exact-alarm, full-screen-intent, notification-policy and foreground-service declarations; where retained, supply valid UX and Play declarations.
11. Replace placeholder FGS subtype and stale/missing native components.
12. Verify target API and build a signed production AAB from the correct flavor/entrypoint with incremented versionCode.
13. Fix iOS purpose strings if iOS remains in scope (not a Play blocker, but a product blocker).
14. Run real regression/security/privacy tests; the current template test is invalid.

## Should Fix Before Resubmission

- HTTPS-only authorized provider allowlist and integrity checks.
- Graceful operation without location/notification permissions.
- Consolidated audio/background implementation and lifecycle cleanup.
- Pinned toolchain/dependencies and SBOM/license report.
- Eliminate template IDs and inconsistent CI/Fastlane versioning.
- Content accuracy validation for Quran, hadith, tafsir and prayer calculation settings.

## Nice to Fix

- Database packaging/performance, accessibility, localization completion, unused dependencies, placeholder feature removal, visual polish.

## Evidence / Documentation Needed

- Original Play rejection email/screenshots and Policy Status record.
- Submitted AAB, signing certificate SHA-256, package ownership and Play developer legal identity.
- Store title/descriptions/icon/screenshots/feature graphic/privacy URL/support contacts.
- License/authorization letters for every recording, reciter/estate, broadcaster, API, image/photo/logo, font/calligraphy set, animation, dataset, translation and digitized tafsir edition.
- Contractor/work-for-hire or design-source proof for app icon and original artwork.
- Provider terms snapshots and permission correspondence, not merely source URLs.
- Asset manifest with hashes linking each binary to its evidence.
- Data Safety worksheet, Firebase collection/configuration evidence, privacy policy version, permission declaration videos/forms.
- All of the above are **NEEDS EXTERNAL VERIFICATION** until supplied.

# 28. Pre-Submission Checklist

- [ ] Obtain original rejection notice and exact cited policy/asset
- [ ] Inventory/hash every release asset and remote content item
- [ ] Remove or quarantine unauthorized/unverified assets
- [ ] Verify ownership of every third-party recording, image, text, dataset and font
- [ ] Verify performer, master-recording, publisher and rebroadcast rights
- [ ] Verify trademark/public-figure usage and affiliation presentation
- [ ] Replace Islamweb-tagged alarm audio or attach explicit authorization
- [ ] Verify MP3Quran/QuranGo/Islamic Network/API permissions
- [ ] Verify Archive.org item-level rights; do not treat hosting as permission
- [ ] Verify AhmedBaset hadith dataset license and upstream sources
- [ ] Verify all four tafsir digitizations and English Quran translation edition/license
- [ ] Verify all 8 bundled fonts and 603 downloadable page fonts
- [ ] Remove Pinterest/Google-cache/news/YouTube hotlinked images
- [ ] Verify application/developer identity, package, signing and support contact
- [ ] Review app name/icon/splash for uniqueness and ownership
- [ ] Review exact store listing, screenshots and feature graphic
- [ ] Publish accurate privacy policy at a stable URL
- [ ] Complete accurate Data Safety form
- [ ] Minimize permissions and document retained sensitive permissions
- [ ] Remove unjustified background location/full-screen/exact-alarm/special-use FGS
- [ ] Replace global cleartext with authorized HTTPS providers
- [ ] Verify Firebase restrictions, Security Rules and telemetry behavior
- [ ] Pin production Flutter/Java/Gradle/AGP/Kotlin toolchain
- [ ] Build only `lnastaqim_prod` from `main_lnastaqim_prod.dart`
- [ ] Verify target API requirement on final AAB
- [ ] Increment and reconcile version name/code
- [ ] Scan merged release manifest and AAB contents
- [ ] Run permission-denial, offline, deep-link, audio/background and privacy tests
- [ ] Review Play Console policy declarations and old active APKs
- [ ] Have qualified IP/privacy counsel review evidence and disclosures

# 29. Top 20 Action Items

| Priority | Category / problem | Evidence / root cause | Fix | Complexity | Risk if ignored | Before resubmission |
|---:|---|---|---|---|---|---|
| 1 | IP: third-party media rights | Islamweb MP3 tag; no provenance process | Remove or obtain written rights | High external | Repeat rejection/claim | YES |
| 2 | Evidence: get rejection record | Not in repo | Export Play notice and artifact | Low | Fix wrong issue | YES |
| 3 | IP: quarantine streaming catalogs | Archive/Matb3aa/QuranGo/etc. | Provider-by-provider authorization | High | IP/rebroadcast rejection | YES |
| 4 | Misrepresentation: ownership text | blanket claim conflicts with sources | Accurate rights/attribution language | Medium/legal | Misrepresentation | YES |
| 5 | Images/public figures | hotlinks and bundled portraits | License or original neutral art | High | Copyright/impersonation | YES |
| 6 | Text/dataset provenance | Quran/tafsir/hadith/azkar sources absent | Edition/license ledger | High | Copyright/content integrity | YES |
| 7 | Font/calligraphy rights | 8 bundled + 603 mirrored fonts | Exact license/source or replace | High | Copyright rejection | YES |
| 8 | Privacy mismatch | policy vs Firebase/Nominatim/network | Runtime inventory + accurate policy | Medium | User Data rejection | YES |
| 9 | Background location | manifest, no evidenced core use | Remove or qualifying disclosure/approval | Medium | Submission block | YES |
| 10 | Restricted permissions | alarms/full-screen/storage/FGS | Least-privilege merged manifest | Medium | Submission block | YES |
| 11 | Release identity | example namespace/Appfile mismatch | Verify and unify identity | Low-Medium | ownership confusion/build error | YES |
| 12 | Reproducible AAB | flavors/toolchain/version drift | single pinned CI production lane | Medium | wrong artifact | YES |
| 13 | Cleartext providers | global flag + HTTP streams | authorized HTTPS allowlist | High/provider | MITM/content substitution | YES |
| 14 | Store listing audit | listing absent | compare exact claims/assets | Medium | repeat listing rejection | YES |
| 15 | Firebase controls | exposed client config/analytics | restrict keys/rules; disclose collection | Medium/external | abuse/privacy | YES |
| 16 | Content integrity | mutable GitHub main/raw downloads | signed/versioned manifests | High | supply-chain substitution | YES |
| 17 | Startup permissions | mandatory location/notification | graceful reduced mode | Medium | abandonment/review failure | SHOULD |
| 18 | Audio/lifecycle architecture | multiple stacks/subscription leaks | partial rewrite unified service | High | crashes/battery | SHOULD |
| 19 | Testing | counter template only | critical-flow release suite | High | regressions | YES |
| 20 | Compliance governance | no SBOM/license/release gate | CI policy and evidence pack | Medium | recurrence | YES |

# 30. Overall Health Score

Scores measure readiness/health (higher is better); the “IP” score measures IP governance health, not amount of risk.

| Dimension | Score | Rationale |
|---|---:|---|
| Architecture | 45 | feature grouping exists; cross-cutting globals/duplication/god files |
| Code Quality | 35 | functional breadth, but stale code, typos, lifecycle and route defects |
| Security | 38 | no malicious code/private secrets found; cleartext, supply-chain and permissions severe |
| Google Play Compliance | 20 | multiple likely blockers and no evidence pack |
| Intellectual Property Governance | 15 | strong external provenance signals, zero rights registry |
| Performance | 40 | huge compiled datasets and heavy pre-run startup |
| Maintainability | 35 | 354k Dart lines, mixed patterns, no tests |
| Scalability | 30 | hardcoded catalogs/URLs and embedded datasets do not scale operationally |
| Testing | 5 | only invalid template test |
| Dependencies | 35 | large/duplicative set, mutable Git dependency, version skew |
| UX/UI | 55 | coherent feature breadth and visuals; mandatory permissions/error gating hurt UX |
| DevOps | 30 | CI/Fastlane exist but build identity/toolchain paths conflict |
| Documentation | 20 | README feature paragraph; no architecture/compliance/provenance/runbooks |

**Overall Project Health Score: 29/100** (rounded arithmetic mean of the 13 dimensions). The score is driven primarily by release-blocking IP evidence gaps, privacy/permission mismatch and absent testing, not by lack of product functionality.

# 31. Final Verdict

1. **Most likely rejection reason:** unverified redistribution/presentation of third-party audio, recordings, images, fonts and datasets, compounded by an inaccurate blanket ownership claim. **Confidence: HIGH.** Exact cited Play clause remains **NEEDS EXTERNAL VERIFICATION** without the rejection notice.
2. **Actual IP risk evidence:** yes. The Islamweb metadata is direct provenance evidence; external GitHub/API/archive/image sources are code-confirmed. Whether permissions exist outside the repo is unknown. **Confidence: HIGH that a rights-evidence gap exists; LOW on legal infringement certainty.**
3. **Most likely category:** primarily **Copyright / Intellectual Property**, secondarily **Misrepresentation**, with possible **Impersonation/Trademark** exposure. **Confidence: MEDIUM-HIGH.**
4. **Elements creating risk:** bundled tagged MP3s; named reciter/ibtihal streams and portraits; Quran/radio providers; GitHub hadith JSON; mirrored Quran fonts; tafsir/Quran translation data; SVG Repo assets; hotlinked publisher/Pinterest/Google/YouTube/government images; blanket copyright statement.
5. **Root cause:** no asset/content provenance and licensing governance, combined with boilerplate legal/privacy claims and no release compliance gate.
6. **Must change:** remove or prove rights for every content item; correct ownership/affiliation/privacy disclosures; minimize permissions; fix release identity and produce a compliant production AAB/listing.
7. **Evidence required:** itemized licenses/authorization letters, API/provider permissions, performer/recording/image/font/data rights, original design proof, developer/package/signing proof, original Play notice and exact store assets.
8. **Architecture salvageable:** partially. Reader/domain/local-state components are salvageable after content validation. Bootstrap, media/provider, permission/background and release layers are not suitable as-is.
9. **Refactor or rewrite:** **PARTIAL REWRITE**, after immediate content/legal FIX. Full rewrite would not itself cure IP provenance.
10. **First action:** obtain the Play rejection record and freeze/quarantine every externally sourced release asset/catalog; build the rights manifest before changing code or resubmitting.

## Required external-verification register

`NEEDS EXTERNAL VERIFICATION`: original rejection and Play Console status; exact submitted AAB/manifest/target SDK; store listing and graphics; developer legal identity and signing ownership; all off-repo licenses/permissions; provider terms at time of use; Firebase Security Rules/API restrictions/collection settings; runtime network capture; Data Safety form; current dependency CVEs/maintenance; current trademark status; exact origin/reverse-image matches for local artwork; exact editions/digitizers of Quran translation/tafsir/hadith/azkar; legal analysis by qualified counsel.

---

## Completion summary

```text
AUDIT COMPLETED

Report:
PROJECT_FORENSIC_AUDIT.md

Google Play Rejection Risk:
HIGH

Intellectual Property Risk:
HIGH

Most Likely Rejection Category:
Copyright / Intellectual Property, compounded by Misrepresentation; possible Impersonation/Trademark exposure

Root Cause:
No asset/content provenance, licensing, authorization, and release-compliance governance; externally sourced content was shipped/streamed while the app asserted blanket ownership.

Overall Project Health:
29/100

Recommended Strategy:
PARTIAL REWRITE (after immediate legal/content FIX)
```
