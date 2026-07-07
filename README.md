# Mabar Sudoku - Flutter

Multiplayer Sudoku game built with Flutter, Riverpod, and Firebase.

## Project Structure

```
lib/
├── main.dart                 # Entry point
├── core/                     # Core utilities
│   ├── constants/           # App, game, Firebase constants
│   ├── errors/              # Exception & Result types
│   ├── theme/               # Material theme
│   ├── firebase/            # Firebase config (placeholder)
│   ├── router/              # Go Router setup
│   └── utils/
├── shared/                  # Cross-feature code
│   ├── services/            # Firebase service
│   ├── repositories/
│   ├── providers/
│   └── widgets/
└── features/                # Feature modules
    ├── auth/                # Authentication (Splash, Login)
    ├── home/                # Home screen
    ├── game/                # Solo Sudoku game logic & UI
    ├── matchmaking/         # (v0.2+)
    ├── chat/                # (v0.3+)
    ├── profile/             # (v0.4+)
    └── leaderboard/         # (v0.4+)
```

## Setup

### Prerequisites
- Flutter 3.13.0+ (Stable channel)
- Dart 3.1.0+
- Firebase project (credentials to be added later)

### Installation

1. **Clone & navigate:**
   ```bash
   cd mabar_sudoku
   ```

2. **Get dependencies:**
   ```bash
   flutter pub get
   ```

3. **Generate Freezed & JsonSerializable files:**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run app:**
   ```bash
   flutter run -d <device_id>
   ```

## Development

### Code Generation

After modifying Freezed models or JsonSerializable classes:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Watch mode (auto-rebuild on changes):
```bash
flutter pub run build_runner watch
```

### Linting & Analysis

```bash
flutter analyze
```

### Testing

```bash
flutter test
```

## Architecture

- **Clean Architecture**: Data, Domain, Presentation layers per feature
- **Riverpod**: State management with providers
- **Freezed**: Immutable models & union types
- **Go Router**: Navigation
- **Firebase**: Auth, Firestore, Cloud Functions (when project ready)

## Current Version (v0.1)

### ✅ Implemented
- Splash screen with 2s delay
- Login screen (Anonymous & Google placeholders)
- Home screen with navigation
- Solo Sudoku game
  - Sudoku generator (backtracking algorithm)
  - Sudoku validator (Sudoku rules)
  - Game state management
  - Interactive board UI (9×9 grid with colors)
  - Numpad (1-9 + erase)
  - Timer & error tracking
  - Difficulty levels (Easy, Medium, Hard)

### ⏳ Next (v0.2+)
- Multiplayer (Create/Join Room)
- Realtime board sync
- Chat & reactions
- Reconnect support
- Ranked mode & Leaderboard

## Firebase Setup

When Firebase project is ready, update:
1. `lib/core/firebase/firebase_config.dart` — Add project credentials
2. `lib/shared/services/firebase_service.dart` — Uncomment production init
3. `lib/features/auth/data/datasources/auth_datasource.dart` — Connect Firebase Auth SDK

No other files need changes due to modular design.

## Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Riverpod Documentation](https://riverpod.dev)
- [Firebase Flutter Documentation](https://firebase.flutter.dev)
- [Go Router Documentation](https://pub.dev/packages/go_router)

## Git Workflow

All code is developed locally, committed, and pushed to Firebase Studio for testing:

```bash
git add <files>
git commit -m "Descriptive message"
git push origin <branch>
```

## Notes

- No `TODO` or `FIXME` comments
- All magic numbers extracted to constants
- UI is dumb — business logic in providers/services
- Server validates all game moves (when Firebase ready)
- Client never decides winner
