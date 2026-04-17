# Shopping List App

A Flutter shopping list app focused on quick list creation, clean shopping flow, and a polished mobile-first UI. The project currently supports local persistence, a themed interface, splash screen flow, and English/Lithuanian localization.

## Features

- Create, edit, and delete shopping lists
- Add, edit, and remove items from a list
- Shopping mode with checked and unchecked item sections
- Select a list before entering shopping mode
- Localized UI with English and Lithuanian support
- Persist shopping lists locally with SharedPreferences
- Splash screen and app settings screen

## Tech Stack

- Flutter
- Dart `^3.11.1`
- `shared_preferences` for local persistence
- `flutter_svg` for SVG assets
- Flutter `gen-l10n` localization workflow with ARB files

## Project Structure

- `lib/main.dart`: app entry point and route setup
- `lib/core/`: app-wide settings and storage infrastructure
- `lib/components/`: shared reusable UI components
- `lib/modules/`: feature modules such as home, settings, shopping list, splash, history, and statistics
- `lib/theme/`: app colors, decorations, assets, and theme configuration
- `lib/l10n/`: localization ARB files and generated localization accessors

## Getting Started

### Prerequisites

- Flutter SDK installed
- Dart SDK matching the Flutter version in use

### Install dependencies

```bash
flutter pub get
```

### Run the app

```bash
flutter run
```

### Analyze the project

```bash
flutter analyze
```

### Regenerate localizations

```bash
flutter gen-l10n
```

## Localization

- Localization files live in `lib/l10n/`
- Supported locales are generated from the ARB files
- The app currently includes English and Lithuanian translations
- Preferred locale is stored locally through the app settings layer

## Local Storage

- Shopping lists are stored locally using `SharedPreferences`
- App-wide settings such as preferred locale are also stored locally
- Storage logic lives in `lib/core/storage_manager.dart`

## Screenshots

Screenshots and UI previews can be added here later.

## Roadmap

### Product

- [ ] Onboarding / first-time indicators
- [x] Decide on app rotation constraints
- [ ] Generate production-ready assets
- [ ] Shopping timer
- [x] Shopping history improvements
- [ ] Shopping item categories
- [ ] Item pricing and total spend
- [ ] Statistics screen improvements
- [ ] AI integration for approximate item prices in Lithuania

### Engineering

- [ ] Investigate more robust storage solutions
- [ ] Continue refactoring the codebase
- [ ] Abstract widgets where it improves clarity and reuse
- [ ] Add a global error handler
- [ ] Add unit tests for core features
- [ ] Add automated user flow tests

## Current Status

The app is in active development. Core list management and shopping flow are implemented, while some advanced features such as richer history, statistics, and test coverage are still in progress.
