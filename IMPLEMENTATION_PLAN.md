# Mabar Sudoku - Flutter Project

## Folder Structure

```
mabar_sudoku/
├── lib/
│   ├── main.dart                          # Entry point
│   ├── core/
│   │   ├── constants/
│   │   │   ├── app_constants.dart         # App-wide constants
│   │   │   ├── game_constants.dart        # Game rules constants
│   │   │   └── firebase_constants.dart    # Firebase collections/functions
│   │   ├── errors/
│   │   │   ├── app_exception.dart         # Exception hierarchy
│   │   │   └── failure.dart               # Result<T> type
│   │   ├── theme/
│   │   │   └── app_theme.dart             # Material theme
│   │   ├── firebase/
│   │   │   └── firebase_config.dart       # Placeholder config
│   │   ├── router/
│   │   │   └── app_router.dart            # Go Router setup
│   │   └── utils/
│   ├── shared/
│   │   ├── services/
│   │   │   └── firebase_service.dart      # Firebase init
│   │   ├── repositories/                  # Cross-feature repos
│   │   ├── providers/                     # Cross-feature providers
│   │   └── widgets/                       # Reusable widgets
│   └── features/
│       ├── auth/
│       │   ├── data/
│       │   │   ├── datasources/
│       │   │   │   └── auth_datasource.dart
│       │   │   └── repositories/
│       │   │       └── auth_repository_impl.dart
│       │   ├── domain/
│       │   │   ├── entities/
│       │   │   │   └── user_entity.dart
│       │   │   └── repositories/
│       │   │       └── auth_repository.dart
│       │   └── presentation/
│       │       ├── providers/
│       │       │   └── auth_provider.dart
│       │       └── widgets/
│       │           ├── splash_screen.dart
│       │           └── login_screen.dart
│       ├── home/
│       │   └── presentation/
│       │       ├── providers/
│       │       └── widgets/
│       │           └── home_screen.dart
│       ├── game/
│       │   ├── data/
│       │   │   ├── models/
│       │   │   │   ├── sudoku_board.dart
│       │   │   │   ├── game_state.dart
│       │   │   │   └── game_move.dart
│       │   │   └── repositories/
│       │   ├── domain/
│       │   │   ├── entities/
│       │   │   ├── repositories/
│       │   │   └── services/
│       │   │       ├── sudoku_validator.dart
│       │   │       └── sudoku_generator.dart
│       │   └── presentation/
│       │       ├── providers/
│       │       │   └── solo_game_provider.dart
│       │       ├── screens/
│       │       │   └── solo_game_screen.dart
│       │       └── widgets/
│       │           ├── sudoku_board.dart
│       │           ├── game_top_bar.dart
│       │           └── numpad.dart
│       ├── matchmaking/
│       ├── chat/
│       ├── profile/
│       └── leaderboard/
├── test/
│   ├── core/
│   ├── features/
│   │   ├── auth/
│   │   └── game/
│   └── shared/
├── firebase/                              # Firebase functions source
├── pubspec.yaml
├── analysis_options.yaml
└── app_config.yaml
```

## Implementation Plan - v0.1

### Phase 1: Auth & Navigation ✓
- [x] Splash screen (2s delay)
- [x] Login screen (Anonymous + Google placeholders)
- [x] Auth provider (Riverpod)
- [x] Router setup (Go Router)
- [ ] Connect Firebase Auth (pending Firebase project)

### Phase 2: Solo Sudoku ✓
- [x] Sudoku generator (backtracking algorithm)
- [x] Sudoku validator (row/col/box rules)
- [x] Game state provider (ChangeNotifier)
- [x] Game UI (board + numpad)
- [ ] Game logic integration (wire providers to UI)
- [ ] Persistence (save/load game state)
- [ ] Difficulty selection

### Phase 3: Core Infrastructure
- [ ] Firebase initialization (when project ready)
- [ ] Error handling & logging
- [ ] Analytics setup
- [ ] Unit tests (game logic)

### Phase 4: Polish (v0.1 release)
- [ ] Animation & transitions
- [ ] Sound effects
- [ ] Haptic feedback
- [ ] Accessibility (WCAG)

## Architecture Overview

**Clean Architecture + Riverpod:**
- **Presentation**: Widgets + Providers (state management)
- **Domain**: Entities + Repositories (business logic interfaces)
- **Data**: Datasources + Repository impls (Firebase/local)

**Hybrid Firebase Strategy:**
- Direct Firestore: Auth, rooms, basic reads/writes
- Cloud Functions: Moves validation, leaderboard, scoring, rewards

**Key Patterns:**
- Freezed for immutable models
- JsonSerializable for serialization
- Go Router for navigation
- Riverpod for state (async + stream providers)

## Next Steps

1. Wire game providers to UI (bind solo_game_provider to game screen)
2. Add persistence layer (local storage for draft games)
3. Set up unit tests for validators/generator
4. Connect Firebase Auth when project is ready
5. Implement difficulty selection modal

## Firebase Placeholders

When Firebase project is ready, update:
- `lib/core/firebase/firebase_config.dart` → project credentials
- `lib/shared/services/firebase_service.dart` → production init
- `lib/features/auth/data/datasources/auth_datasource.dart` → real Auth SDK

No other files need changes due to modular design.
