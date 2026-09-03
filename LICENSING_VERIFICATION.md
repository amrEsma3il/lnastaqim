# Licensing Verification

**Project:** Lnastaqim Flutter application  
**Audit date:** 2026-08-24  
**Scope:** Focused, read-only verification of the external content and font sources identified in `PROJECT_FORENSIC_AUDIT.md`  
**Legal status:** Technical and policy-risk analysis, not legal advice

## Executive conclusion

The repository does **not** contain a complete, reviewable chain of rights for its externally sourced recordings, datasets, fonts, and SVGs. The highest-confidence licensing problem is the bundled Ahmed Al‑Trabolsy adhan: its embedded metadata identifies Islamweb, while Islamweb's published agreement limits copying/downloading to personal, non-commercial use and prohibits public or commercial redistribution without prior written consent. The app permanently ships the recording in every install and duplicates it in Android source sets. No such consent is present.

The next most serious issues are the downloaded Hadith corpus, the downloadable Archive.org/Matb3aa recordings, and several proprietary or unidentified fonts. Public availability, direct file URLs, an API endpoint, and an Internet Archive item page are not themselves redistribution licenses.

This pass does **not** establish the exact text of the policy notice that Google sent, the Play Console listing presented at rejection, the relevant historical provider terms, or any authorization held outside this repository. Those matters are **NEEDS EXTERNAL VERIFICATION**. Nevertheless, the Islamweb-tagged bundled recording is a concrete, repository-verifiable candidate for an automated or manual intellectual-property rejection.

### Verdict scale

- **COMPLIANT:** the located terms expressly permit the observed use and the repository evidence meets the material conditions reviewed.
- **NON-COMPLIANT:** the observed use conflicts with an express term, or the work is redistributed despite an authoritative statement that no redistribution right exists without a license.
- **UNCLEAR:** the provider grants only conditional/ambiguous rights, no authoritative terms were found, the particular item's license was not provable, or required rights may sit with another rightsholder.

## Required summary table

| Source | How the app uses it | Provider's actual published terms (quoted/cited) | Compliant? | Required action |
|---|---|---|---|---|
| **www.islamweb.net — Ahmed Al‑Trabolsy adhan MP3** | Permanently bundles one MP3 in Flutter assets and three Android `raw` source sets; uses it as notification/alarm audio. This is distribution with the APK/AAB, not streaming. The ID3 artist/comment fields identify `www.islamweb.net` and the album field says `©2013`. | Islamweb permits viewing/downloading/printing only for “personal, noncommercial use,” requires notices to be retained, and prohibits copying, modifying, distributing, republishing, displaying, or transmitting content for commercial **or public** purposes without explicit prior written consent. Commercial/promotional use also requires prior written permission. [Islamweb Service Agreement (official PDF)](https://www.islamweb.net/service_agreement/en.pdf) | **NON-COMPLIANT** on repository evidence. No consent or recording license is present. | Remove the recording from every bundle before resubmission, or obtain and retain written permission covering mobile-app redistribution, notifications/alarms, territories, term, and commercial use. Separately confirm performer, composition, and master-recording rights. |
| **mp3quran.net / live.mp3quran.net** | Stores an API provenance comment, embeds many live-radio URLs, and streams them through `AudioPlayer` as `UrlSource`; no MP3Quran radio-download path was found. | MP3Quran's official contact page states: “All rights are available to everyone,” and expressly allows “copying any material on the site or using any URL on the website,” directing reviewers to its privacy URL as proof. Its official developer page publicly documents the v3 API and radio endpoint. [MP3Quran contact statement](https://www.mp3quran.net/eng/contact-us), [MP3Quran API documentation](https://www.mp3quran.net/fr/api/2) | **COMPLIANT** for the observed MP3Quran URL use, subject to preserving evidence of the grant. The statement does not identify a formal license, warranty, attribution rule, or irrevocability. | Archive a dated copy/PDF of the permission statement and obtain provider confirmation that commercial Play-distributed apps may stream each radio channel. Replace HTTP streams with HTTPS for security; that is not a license condition. |
| **qurango.net / backup.qurango.net** | Hardcodes two active `qurango.net` streams and approximately 141 `backup.qurango.net` catalog URLs. The radio player streams URLs; the catalog was apparently derived from the MP3Quran radio endpoint. | No official Qurango terms, license, or content-rights page was located. MP3Quran's broad copying/URL statement cannot automatically be transferred to a different domain/operator or to underlying reciter rights. | **UNCLEAR**. Public streams and API-derived URLs do not prove a license. | Obtain written Qurango authorization covering in-app streaming, commercial distribution, catalog copying, attribution, and takedown/revocation. If Qurango is operated by MP3Quran, obtain documentary confirmation linking the domains and grant. |
| **cdn.islamic.network / Al Quran Cloud** | Hardcodes 15 reciter collections. The app can stream a verse, download verse MP3s to application storage for offline playback, and retain those files. | Current terms apply to the API and Islamic Network CDN. They say recitations are licensed for “free, non-commercial redistribution,” permit streaming/embedding/downloading for personal and educational use, then also say they “may” be bundled into a commercial product. Copyright remains with reciters, who may request removal. The service may amend terms; full mirrors/high throughput should contact the operator. [Al Quran Cloud Terms](https://alquran.cloud/terms-and-conditions) | **UNCLEAR**. Streaming/offline download is expressly contemplated, but the non-commercial grant and commercial-bundling sentence conflict; the provider does not warrant reciter-specific rights and reserves practical takedown exposure. Terms are dated 2026-06-14, after this old app's likely submission. | Obtain written, reciter-specific confirmation for all 15 edition IDs, including commercial app use, user offline copies, attribution, and a takedown process. Add a remotely disableable catalog and record the terms/version accepted. Historical terms at rejection are **NEEDS EXTERNAL VERIFICATION**. |
| **archive.org / Internet Archive audio items** | Hardcodes direct MP3 URLs from five named Archive items. The Ibtihal feature streams, downloads files permanently to app documents, plays offline files, and exposes a share action for downloaded recordings. | Internet Archive states it cannot guarantee item copyright status or item-page rights metadata; users use Collections at their own risk and must ensure use is non-infringing. A declared per-item Creative Commons or other license, if trustworthy, governs that item—not Archive hosting itself. [Internet Archive rights FAQ reproduced in USPTO record](https://ptacts.uspto.gov/ptacts/public-informations/petitions/1490774/download-documents?artifactId=Mc3PETIgQzjbX78Ce9k7pyxlGHxBbybfGVx8Qgf7ES5agOq31vI2Pok), [Internet Archive Terms](https://archive.org/about/terms) | **UNCLEAR; high risk**. No item-specific license or rightsholder permission for the five identifiers is stored in the repository, and the app enables durable download and sharing rather than mere linking. | Disable/remove these sources until each recording's uploader, performer, producer/master owner, composition, license, and commercial redistribution rights are documented. Preserve item metadata and license snapshots. Sharing needs an explicit onward-distribution right. |
| **matb3aa.com audio** | Hardcodes six direct `.mp3` files for Al‑Naqshabandi. The same Ibtihal player supports streaming, permanent offline download, and sharing. Filenames include the site's brand but no license or attribution record. | No authoritative provider terms, API terms, or audio-redistribution license was found. That absence is a finding; it is not permission. | **UNCLEAR; high risk**. There is no provable grant for streaming inside a third-party app, downloading, sharing, or commercial bundling. | Remove/disable pending written authorization from Matb3aa and the recording rightsholders. Permission must cover streaming, offline copying, onward sharing, territories, attribution, and commercial Play distribution. |
| **raw.githubusercontent.com/AhmedBaset/hadith-json** | Downloads nine complete JSON books through Dio to app documents, then reads the persistent offline files. This is bulk copying and product-integrated redistribution/use, not a transient API lookup. | The public repository did not expose a license file or license declaration in the evidence located. GitHub's official guidance is explicit: without a license, default copyright applies and others may not reproduce, distribute, or create derivative works; a public repo grants GitHub users view/fork rights, not a general off-platform redistribution license. [GitHub licensing guidance](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/licensing-a-repository), [AhmedBaset repository](https://github.com/AhmedBaset/hadith-json) | **NON-COMPLIANT** absent separate permission. GitHub accessibility is not a data license. Underlying Arabic editions/translations may have additional rightsholders. | Stop production use until the maintainer supplies an explicit license and provenance/permission for every underlying edition and translation. Prefer a licensed dataset/API. Preserve attribution and license text in-app and in a provenance registry. |
| **Amiri.ttf** | Bundled in the app and used widely for UI text. The binary embeds copyright notices, Reserved Font Name “Amiri,” and the complete SIL OFL 1.1 text. No modification was identified. | OFL 1.1 permits original or modified fonts to be bundled, redistributed, and sold with software if each copy contains the copyright notice and license; the font cannot be sold by itself, and Reserved Font Names constrain modified versions. SIL confirms commercial mobile-app bundling is allowed. [SIL OFL text/FAQ](https://software.sil.org/oflt/), [official OFL site](https://openfontlicense.org/) | **COMPLIANT** for the observed unmodified bundling. The required notice/license is embedded in the binary, although discoverability is poor. | Add a human-readable OFL/third-party-notices entry in the release and verify the shipped binary is unchanged. Do not use author names for endorsement. |
| **NotoNaskhArabic-VariableFont_wght.ttf** | Bundled and actively used as family `Naskh` for Quran UI. | Noto fonts are distributed through Google's font repository under per-family license files; Noto Naskh Arabic is an OFL family. OFL permits commercial app bundling under the conditions above. [Google Fonts repository](https://github.com/google/fonts), [SIL OFL text/FAQ](https://software.sil.org/oflt/) | **COMPLIANT**, conditional on this binary being the unmodified OFL build and retaining its copyright/license metadata. | Add the exact family `OFL.txt` and copyright record to third-party notices; record the upstream commit/checksum. |
| **UthmanicHafs_V20.ttf — King Fahd Complex** | Bundled and used as `Authmanic` in Hadith, favorites, sharing, and app-bar text. | The font's embedded EULA says KFGQPC retains ownership and grants, free of cost, rights to “Use, Copy, Distribute,” but prohibits selling, modifying, altering, translating, reverse engineering, decompiling, disassembling, reproducing, or attempting source discovery. Its name table also contains an apparently conflicting sentence that it “may not be reproduced” without express approval. No current official foundry license page was retrievable during this pass. | **UNCLEAR**. Unmodified free-of-cost distribution appears intended, but the internal contradiction and “cannot be Sold” language leave commercial paid-app bundling unresolved. No separate license/authorization record is present. | Obtain written KFGQPC confirmation for commercial mobile-app embedding and clarify “Distribute” versus “may not be reproduced.” Keep the font unmodified and ship the exact EULA. If confirmation is unavailable, replace it with an OFL-licensed Quran font. |
| **QCF_BSML.ttf — King Fahd Complex / Harf** | Bundled as family `Basmala`; no active `fontFamily` reference was located, but `pubspec.yaml` causes distribution in the app. | Embedded metadata says “King Fahad Complex, All rights reserved,” “Harf Information Technology,” and version 5.10. It contains no redistribution grant. The UthmanicHafs EULA cannot be assumed to cover this different font file. No authoritative published license for this exact binary was located. | **NON-COMPLIANT** absent separate authorization: an all-rights-reserved binary is being redistributed with no grant in evidence. | Remove it if unused. Otherwise obtain a license from the identified rightsholders that expressly permits app embedding/redistribution and include the license record. |
| **thuluth-decorated.ttf — DecoType, “MS Office Edition”** | Bundled and actively used for Qibla-screen text. | Embedded metadata says “Copyright 1992-1998 DecoType” and “MS Office Edition.” Microsoft states document-embedding rights do **not** authorize embedding fonts in apps/games/devices; Windows-supplied fonts generally may not be redistributed, and shipping with an app requires extended rights from the owner/foundry. Microsoft also says fonts supplied with other apps are governed by those apps' agreements. [Microsoft Font Redistribution FAQ](https://learn.microsoft.com/en-us/typography/fonts/font-faq) | **NON-COMPLIANT** on available evidence. The repository has no DecoType mobile-app/redistribution license, and an Office edition is being copied into a non-Office app. | Remove/replace with an OFL alternative, or acquire a DecoType app-embedding license for this exact font/version. An Office installation/license is insufficient. |
| **Al Mushaf Quran.ttf — Alvi Technologies** | Bundled as `Mushaf`; no active family reference was located, but the binary is still shipped. | Embedded metadata identifies designer Amjad Hussain Alvi, Alvi Technologies, September 2008, and `alvitechnologies.com`, but contains no license grant. No authoritative foundry EULA/redistribution page for this exact file was located. | **UNCLEAR; high risk**. No evidence permits commercial mobile-app redistribution. | Remove if unused. Otherwise obtain the exact Alvi EULA and written mobile-app embedding rights; record the binary checksum and provenance. |
| **Al Majeed Quranic Font_shiped.ttf** | Bundled and used as `Majeed` for Quran search results. | Embedded metadata lists credits and a 2009 version but no copyright license, redistribution permission, or authoritative source URL. No authoritative publisher/foundry license for this exact binary was located. Third-party download sites are not reliable license grants. | **UNCLEAR; high risk**. | Replace with a documented OFL font or obtain written rights from the actual copyright holder(s), including commercial embedding and redistribution. |
| **ArabQuranIslamic140-7BG9A.ttf** | Bundled and actively used as `Arab140` in Hadith screens. | The binary yielded no authoritative license or foundry record in the available metadata inspection. No provider-published license for this exact file was located. | **UNCLEAR; high risk**. | Remove/replace pending provenance and written licensing. Do not rely on a download-site “free font” label. |
| **radio_feature_icon.svg — SVG Repo Mixer Tools** | Bundled and actively used as the radio feature icon. File comment says it was uploaded to SVG Repo and “Transformed by: SVG Repo Mixer Tools.” | SVG Repo says transformed/remixed public-domain or open-source vectors automatically fall under the default **SVG Repo License**: copying, limited distribution, remixing, and use in a commercial project are permitted; attribution is not required; resale as-is and SVG-repository-like redistribution are prohibited. It also warns that individual icon pages may specify different terms and disclaims remix legality. [SVG Repo Licensing](https://www.svgrepo.com/page/licensing), [SVG Repo Terms](https://www.svgrepo.com/page/terms-of-use/) | **UNCLEAR** for this exact file. The comment points toward the default transformed-content tier, under which in-app use would be compliant, but it lacks the original icon URL/ID and original license needed to confirm eligibility for transformation. | Recover the exact source page/download record and original license. Store them with a checksum. If unavailable, replace with an original or fully documented icon. |
| **mosque_feature.svg — SVG Repo Mixer Tools** | Bundled and has a constant in `images.dart`; no actual widget use was located. File comment says “Generator: SVG Repo Mixer Tools.” | Same SVG Repo default-license terms as above. The generic generator comment is not an item-specific license record and SVG Repo says single icon pages can differ. | **UNCLEAR** for the exact file; likely allowed under the default tier only if its source was eligible and its page did not specify another license. | Remove if unused or recover the exact source/license record. Do not treat the generator comment alone as conclusive provenance. |

## Repository evidence and usage trace

### 1. Islamweb recording

The same recording exists at:

- `assets/sounds/notification_and_alarms/ahmed_eltrabolsy_fajr.mp3`
- `android/app/src/main/res/raw/ahmed_eltrabolsy_fajr.mp3`
- `android/app/src/dev/res/raw/ahmed_eltrabolsy_fajr.mp3`
- `android/app/src/prod/res/raw/ahmed_eltrabolsy_fajr.mp3`

Media metadata inspection found the title identifying Ahmed Al‑Trabolsy, artist/comment `www.islamweb.net`, and album `©2013`. The repository contains no Islamweb authorization, license receipt, attribution register, performer release, or master-recording license. Copying the file across source sets and shipping it in the app is materially different from a user's personal download from Islamweb.

**Revocation/continuity:** Islamweb's agreement allows changes to the service/terms and termination of access. Even a current written permission should specify duration and revocation/takedown handling. Historical ownership and 2013 acquisition facts are **NEEDS EXTERNAL VERIFICATION**.

### 2. MP3Quran and Qurango

Repository references:

- `lib/core/local_database/quran/quran_transition_json.dart:3` records an MP3Quran v3 API URL.
- `lib/core/local_database/radio/radio_local_database.dart:2` records the MP3Quran radio API; the file embeds `backup.qurango.net` URLs from lines 10–850.
- `lib/features/radio_stream_channels/data/data_sources/local_data_sources/radio_json.dart:75-186` contains active HTTP MP3Quran streams.
- `lib/features/radio_stream_channels/data/data_sources/local_data_sources/radio_json.dart:9,196` contains active Qurango streams.
- `lib/features/radio_stream_channels/bussniess_logic/radio_cubit.dart:131` passes the selected URL directly to `AudioPlayer`.

The MP3Quran statement is unusually broad and supports both API/catalog copying and URL use. It does not expressly address attribution, sublicensing, service-level guarantees, revocation, or the separate publicity/performer rights of named reciters. Accordingly the technical verdict is compliant for URL use, but evidence preservation and direct confirmation remain prudent.

No provider-published terms were found for Qurango. **NEEDS EXTERNAL VERIFICATION:** corporate/domain relationship between MP3Quran, Qurango, and `backup.qurango.net`; whether the MP3Quran permission covers the backup host; whether every channel owner authorized third-party app streaming.

### 3. Islamic Network Quran audio

`lib/features/quran_sound/data/models/reciter_entity.dart:45-128` defines 15 CDN collections. `lib/features/quran_sound/logic/audio_cubit/audio_cubit.dart:113-249` selects local files when present and constructs remote verse URLs for download/offline storage.

The terms' commercial-use wording is internally inconsistent: it describes the upstream grant as non-commercial and personal/educational, then permits commercial-product bundling while warning that reciters retain copyright and can demand removal. This is not a stable chain of title suitable for a rejection appeal without provider and reciter documentation. The app also has no visible source/license registry or remotely managed takedown list.

### 4. Archive.org and Matb3aa Ibtihal/Tawashih recordings

`lib/core/local_database/ibtihal/ibtihalat_data.dart` directly embeds:

- Archive identifiers `3baqera_omran`, `20230916_20230916_0318`, `Sama3almelouk_yahoo_20160525`, `Ebtihalet_uP_bY_mUSLEm`, and `Tobar1` (lines 13–119, 144, and 181–216).
- Six Matb3aa MP3s under `/music/ALnakshabandy/` (lines 132, 138, 150, 156, 162, and 167).

`lib/features/ibtihal/bussnies_logic/ibtihal_player_cubit.dart:151-184` streams or plays the saved file; lines 501–614 download it permanently; lines 621–632 and the UI share control expose onward sharing. This is the riskiest possible use profile where only hosting/access, rather than redistribution, has been demonstrated.

No item-license snapshot, creator/uploader attestation, label/broadcaster permission, performer consent, master license, or composition license appears in the repository. Item-specific license fields and the legal status of these older recordings are **NEEDS EXTERNAL VERIFICATION**. Age, religious subject matter, or Archive availability does not establish public-domain status.

### 5. AhmedBaset Hadith dataset

`lib/features/7adis/bussiness_logic/a7adith_cubit.dart:40-397` contains nine raw GitHub URLs. `lib/features/7adis/data/hadith_service/hadith_service.dart:32-53` downloads each JSON file into application documents for persistent use.

No license is embedded in the app, no attribution/source screen identifies the dataset, and no permission record is present. Even if the Arabic Hadith wording itself is not protected in a particular jurisdiction, the selection, arrangement, annotations, English translations, database compilation, and JSON production can carry separate rights. Those underlying rights and dataset provenance are **NEEDS EXTERNAL VERIFICATION**.

### 6. Font-by-font provenance result

All eight files are declared under `pubspec.yaml:132-159`; therefore every file is distributed even where no active `fontFamily` call was found. Runtime-use searches found Majeed, Naskh, Thuluth, Amiri, Arab140, and Authmanic. Mushaf and Basmala appear unused but remain release artifacts.

The repository contains no centralized `LICENSES`, `NOTICE`, font purchase receipt, original download package, or provenance manifest. Only Amiri contains a complete, directly readable OFL declaration. Noto's upstream family is OFL, but the exact download commit is not recorded. The proprietary/unidentified fonts cannot be cleared by inference from their names.

Commercial-app bundling conclusions:

- **Amiri:** permitted under OFL conditions — **YES**.
- **Noto Naskh Arabic:** permitted under OFL conditions — **YES**, assuming exact upstream/unmodified identity.
- **UthmanicHafs V20:** distribution appears permitted free of cost, but paid/commercial app treatment and conflicting reproduction text need confirmation — **UNCLEAR**.
- **QCF_BSML:** no grant; “All rights reserved” — **NO on present evidence**.
- **DecoType Thuluth MS Office Edition:** standard Office/Windows rights do not permit app shipment — **NO absent an extended DecoType license**.
- **Al Mushaf Quran / Alvi Technologies:** no foundry license found — **UNCLEAR**.
- **Al Majeed Quranic:** no authoritative rightsholder/license found — **UNCLEAR**.
- **ArabQuranIslamic140:** no authoritative rightsholder/license found — **UNCLEAR**.

### 7. SVG Repo assets

The exact comments are:

- `assets/images/radio_feature_icon.svg:3`: “Uploaded to: SVG Repo, www.svgrepo.com, Transformed by: SVG Repo Mixer Tools”.
- `assets/images/mosque_feature.svg:1`: “Uploaded to: SVG Repo, www.svgrepo.com, Generator: SVG Repo Mixer Tools”.

The first comment most directly points to SVG Repo's **default SVG Repo License for transformed/remixed content**. The second identifies the tool but not necessarily a license tier. Neither includes the original page, icon ID, author, original license, or download date. SVG Repo itself states that single pages may differ and disclaims legal conflict arising from remixing. Therefore the general license is commercially friendly, but exact-file compliance remains unverified.

## Licensing characteristics by use mode

| Source | Personal use | Streaming | Download/offline caching | Commercial app bundling | Attribution | Revocation/takedown |
|---|---|---|---|---|---|---|
| Islamweb MP3 | Expressly allowed for personal non-commercial use | No standalone third-party-app grant found | Personal download only | Prior written consent required; public distribution prohibited without it | Retain notices | Terms/service can change or terminate |
| MP3Quran | Broad copying/material/URL use statement | Expressly supported by URL-use language | Broad statement appears to allow copying, but app does not download these streams | Not expressly limited; seek confirmation | None stated | Not stated; no irrevocable license found |
| Qurango | Not found | Not found | Not found | Not found | Not found | Not found |
| Islamic Network audio | Personal/educational permitted | Permitted | Permitted; CDN asks for caching | Terms say may bundle, despite describing upstream grant as non-commercial | Reciter/edition attribution should be documented; explicit hard mandate is not clear | Reciters may request removal; terms may change |
| Internet Archive items | Depends on each item/rightsholder | Hosting does not itself grant reuse | Depends on each item | Depends on each item | Depends on each item license | Items can be challenged/removed |
| Matb3aa audio | Not found | Not found | Not found | Not found | Not found | Not found |
| AhmedBaset dataset | GitHub view/fork only under platform terms | Not applicable | No off-platform reproduction grant | No grant | No license terms | Repository owner can change/remove content; that does not cure existing copies |
| OFL fonts | Permitted | Not applicable | Permitted | Permitted when bundled with software and notices/license are included | Copyright and license must accompany copies; public UI credit not required | Existing OFL grant is not presented as revocable |
| KFGQPC UthmanicHafs | Use permitted | Not applicable | Copy/distribute permitted subject to EULA | Unclear if font/app is sold | Keep EULA and ownership metadata | No express revocation term found in embedded EULA |
| SVG Repo default tier | Permitted | Not applicable | Copy/distribute with limitations | Use as part of commercial project permitted | Waived/not required, appreciated | Terms can change; exact item license may differ |

## Relationship to the prior Google Play rejection

### Most likely licensing root cause

**Finding:** A third-party-branded, copyright-marked audio recording is permanently embedded in the application without any repository evidence of redistribution permission.

**Immediate cause:** `ahmed_eltrabolsy_fajr.mp3` identifies Islamweb in its ID3 metadata and is distributed four times across Flutter/Android assets.

**Underlying cause:** Content was copied into release artifacts and remote media/data URLs were productized without collecting item-level licenses, rightsholder identities, allowed-use modes, attribution rules, or takedown obligations.

**Root cause:** The project has no enforceable content-ingestion and asset-provenance process. There is no rights registry, approval gate, license inventory, evidence archive, expiry/revocation handling, or release check that blocks unverified media/fonts/data.

**Why Google Play could detect it:** Store reviewers or automated unpacking can inspect packaged filenames and MP3 metadata; the file exposes a third-party domain and copyright marker inside the release. The app also presents named reciters and direct third-party media without an in-app provenance/license record.

**Confidence that the Islamweb file materially contributed to the IP rejection: HIGH.** This is not proof of Google's internal decision. The rejection notice and submitted artifact are **NEEDS EXTERNAL VERIFICATION**.

### Other plausible contributors

- **HIGH confidence risk:** unlicensed proprietary font redistribution, especially the obvious “MS Office Edition” font and all-rights-reserved QCF font.
- **HIGH confidence risk:** direct download and sharing of named performers' Archive.org/Matb3aa recordings without item licenses.
- **HIGH confidence risk:** full Hadith JSON downloads from an unlicensed GitHub repository.
- **MEDIUM confidence risk:** unclear reciter-specific commercial rights for Islamic Network downloads.
- **LOW-to-MEDIUM confidence risk:** SVG Repo files; the default tier is permissive, but exact-item evidence is missing.
- **LOW confidence risk:** MP3Quran URL streaming, because the provider publishes an unusually broad express permission.

## Required action before resubmission

1. Remove the Islamweb-tagged MP3 from Flutter assets and every Android source set unless written redistribution permission is obtained.
2. Remove or license `thuluth-decorated.ttf` and `QCF_BSML.ttf`; an Office license and “all rights reserved” metadata are not app-distribution grants.
3. Quarantine/replace Al Mushaf, Al Majeed, and ArabQuranIslamic140 until exact authoritative licenses are documented.
4. Disable Ibtihal download/share and remove unlicensed Archive/Matb3aa sources until recording-level rights are proven.
5. Stop downloading the AhmedBaset dataset in production until a license and underlying-content provenance are obtained.
6. Obtain written Islamic Network/reciter confirmation for the exact 15 recitation editions and offline/commercial use.
7. Obtain Qurango's written permission and establish its relationship, if any, to MP3Quran.
8. Recover the exact SVG Repo item pages/licenses or replace both SVGs.
9. Add a versioned asset/content provenance register containing source URL, rightsholder, license, allowed uses, attribution, checksum, acquisition date, evidence copy, expiry, and takedown contact.
10. Prepare an appeal/resubmission evidence pack containing the original Play notice, prior submitted AAB hash, replacement/removal diffs, authorization letters, licenses, in-app attribution screenshots, privacy disclosures, and developer/brand ownership evidence.

## External verification register

The following cannot be established from this repository or the provider pages located and must not be represented as facts:

- The exact Google Play policy clause, complained-of asset, reporter/rightsholder, and submitted store listing.
- Whether the owner has Islamweb, reciter, label, broadcaster, font, dataset, or SVG licenses stored outside the repository.
- The provider terms in force on the original submission/rejection date.
- Whether Islamweb owns the master and performer rights needed to sublicense the adhan.
- Whether Qurango and MP3Quran share an operator or rights grant.
- Item-level rights for all five Internet Archive identifiers.
- Matb3aa's authority over the Al‑Naqshabandi recordings.
- Copyright/public-domain status by territory for individual performances, compositions, editions, and translations.
- Exact provenance/checksum correspondence of Noto Naskh and the original Google Fonts build.
- Whether the app was or will be paid, ad-supported, donation-supported, or otherwise commercially monetized at resubmission.
- Exact SVG Repo item pages and original license tiers.

## Final licensing verdict

**Overall licensing readiness: NOT READY FOR RESUBMISSION**  
**Google Play IP rejection risk from verified repository evidence: HIGH**  
**Most likely concrete trigger: Islamweb-identifying, copyright-marked Ahmed Al‑Trabolsy audio bundled without documented redistribution permission**  
**Primary systemic root cause: no asset/content provenance and license-governance process**  
**Confidence: HIGH for the existence of the risk; MEDIUM-HIGH that it was the specific prior rejection trigger**

No source code, configuration, dependency, or asset was modified during this verification. Only this report was created.
