# Spotstock Inventory

A Flutter-based Point of Sale (POS) and inventory management application designed for offline-first operation with automatic synchronization when connectivity is restored.

## Table of Contents

- [Platform Support](#platform-support)
- [Architecture](#architecture)
- [Folder Structure](#folder-structure)
- [State Management](#state-management)
- [Data Flow](#data-flow)
- [Online / Offline Support](#online--offline-support)
- [Reusable Components](#reusable-components)
- [Setup and Running the App](#setup-and-running-the-app)
- [Project Conventions](#project-conventions)
- [Testing](#testing)
- [Future Work / Roadmap](#future-work--roadmap)

---

## Platform Support

| Platform | Status |
|----------|--------|
| Android  | Supported |
| iOS      | Supported |
| macOS    | Planned |
| Windows  | Planned |
| Linux    | Planned |

The application is designed to support both **mobile** and **desktop** platforms via the `PlatformService` class. Currently, only mobile views have been implemented. Desktop support is scaffolded in the routing layer but views are not yet implemented.

```dart
// lib/features/platform/platform_service.dart
bool get isMobile => currentPlatform == AppPlatform.mobile;
bool get isDesktop => currentPlatform == AppPlatform.desktop;
```

The `main.dart` conditionally selects the appropriate router based on platform:

```dart
SpotstockNavigation.init(isMobile ? SpotstockRouter.mobileRouter : SpotstockRouter.desktopRouter);
```

---

## Architecture

The application follows **Clean Architecture** principles with clear separation of concerns across three layers:

### Presentation Layer
- **Views**: Flutter widgets that render the UI
- **ViewModels**: Business logic orchestrators extending `SpotstockViewModel` (a `ChangeNotifier`)
- **Widgets**: Feature-specific UI components

### Domain Layer
- **Use Cases**: Single-purpose classes that encapsulate business rules (e.g., `CreateSale`, `SyncHolds`)
- **Repositories**: Abstract interfaces defining data contracts
- **Errors**: Domain-specific error types

### Data Layer
- **Repository Implementations**: Concrete implementations coordinating local and remote data sources
- **Data Sources**: Local (Drift database) and remote (Dio HTTP client) data sources
- **Models**: Data transfer objects (DTOs) and entity models with Freezed/JSON serialization
- **Mappers**: Transform between data models and domain entities

```
┌─────────────────────────────────────────────────────────────┐
│                     Presentation Layer                       │
│  ┌─────────┐    ┌─────────────┐    ┌─────────────────────┐  │
│  │  Views  │◄───│  ViewModels │◄───│  Widgets/Components │  │
│  └─────────┘    └──────┬──────┘    └─────────────────────┘  │
│                        │                                     │
├────────────────────────┼────────────────────────────────────┤
│                        ▼                                     │
│                     Domain Layer                             │
│  ┌─────────────┐    ┌─────────────┐    ┌───────────────┐    │
│  │  Use Cases  │◄───│ Repositories│    │    Errors     │    │
│  │             │    │ (Interfaces)│    │               │    │
│  └──────┬──────┘    └─────────────┘    └───────────────┘    │
│         │                                                    │
├─────────┼────────────────────────────────────────────────────┤
│         ▼                                                    │
│                      Data Layer                              │
│  ┌─────────────────┐    ┌─────────────────────────────────┐ │
│  │  Repositories   │    │         Data Sources            │ │
│  │ (Implementations)│───►│  ┌────────┐    ┌───────────┐   │ │
│  └─────────────────┘    │  │ Local  │    │  Remote   │   │ │
│                         │  │ (Drift)│    │  (Dio)    │   │ │
│  ┌─────────────────┐    │  └────────┘    └───────────┘   │ │
│  │ Models/Mappers  │    └─────────────────────────────────┘ │
│  └─────────────────┘                                        │
└─────────────────────────────────────────────────────────────┘
```

---

## Folder Structure

```
lib/
├── main.dart                      # Application entry point
├── core/                          # Shared application infrastructure
│   ├── assets/                    # Asset path constants
│   ├── constants/                 # App-wide constants (sizes, strings, keys, durations)
│   ├── database/                  # Drift database client and table definitions
│   │   ├── database_client.dart   # Main database configuration
│   │   └── tables/                # Table definitions (LocalHolds, LocalCustomers, etc.)
│   ├── di/                        # Dependency injection setup (GetIt)
│   │   └── di.dart                # Service locator configuration
│   ├── domain/                    # Core domain interfaces
│   │   └── usecases/              # Abstract use case classes
│   ├── enums/                     # Application-wide enumerations
│   ├── error_handling/            # Error types and handling utilities
│   ├── local_storage/             # SharedPreferences/SecureStorage wrapper
│   ├── networking/                # Dio HTTP client, interceptors, API constants
│   ├── permissions/               # Permission handling utilities
│   ├── presentation/              # Reusable UI components (see Reusable Components)
│   ├── routing/                   # GoRouter configuration
│   │   ├── navigation.dart        # Navigation helper
│   │   └── router.dart            # Route definitions (mobile/desktop)
│   └── shared/                    # Shared utilities
│       ├── command.dart           # Command pattern for async operations
│       └── result.dart            # Result type (Success/Failure)
│
└── features/                      # Feature modules
    ├── auth/                      # Authentication feature
    │   ├── data/                  # Datasources, repositories, models
    │   ├── domain/                # Use cases, repository interfaces
    │   ├── presentation/          # Views, view models
    │   └── services/              # Password hashing, salt generation
    ├── holds/                     # Order holds management
    ├── home/                      # Dashboard/home screen
    ├── network_info/              # Network connectivity monitoring
    ├── platform/                  # Platform detection service
    ├── pos/                       # Point of Sale (main feature)
    │   ├── constants/             # POS-specific constants
    │   ├── data/
    │   │   ├── datasources/       # local/, remote/
    │   │   ├── enums/
    │   │   ├── mappers/
    │   │   ├── models/
    │   │   └── repositories/
    │   ├── domain/
    │   │   ├── errors/
    │   │   ├── repositories/
    │   │   └── usecases/
    │   └── presentation/
    │       ├── view/
    │       ├── view_model/
    │       └── widget/
    ├── receipt/                   # PDF receipt generation and printing
    ├── register_management/       # Cash register open/close
    ├── splash/                    # Splash screen
    ├── staff_pin/                 # Staff PIN verification
    ├── summary/                   # Sales summary
    ├── sync/                      # Offline data synchronization
    └── webview/                   # WebView integration
```

---

## State Management

The application uses **ChangeNotifier-based ViewModels** with a custom **Command pattern** for managing asynchronous operations.

### Core Components

**SpotstockViewModel**
All ViewModels extend `SpotstockViewModel`, which extends `ChangeNotifier` and provides:
- Error stream for propagating errors to the UI
- `bind(BuildContext context)` lifecycle method

**Command Pattern**
Async operations are wrapped in `Command` objects that track running state and results:

```dart
// lib/core/shared/command.dart
abstract class Command<T> extends ChangeNotifier {
  bool get running;        // Whether the action is executing
  bool get hasFailure;     // Whether the action failed
  bool get hasSuccess;     // Whether the action succeeded
  Result<T>? get result;   // The result of the most recent action
}
```

Commands are available in variants: `Command0` (no args), `Command1<T, A>`, `Command2<T, A, B>`, `Command3<T, A, B, C>`.

**Result Type**
Operations return a sealed `Result<T>` type:

```dart
// lib/core/shared/result.dart
sealed class Result<T> {
  factory Result.success(T data) = Success<T>;
  factory Result.failure(AppError error) = Failure<T>;
}
```

### Where State Lives

- **UI State**: Managed in ViewModels (e.g., `PosViewModel`, `LoginViewModel`)
- **Session State**: Stored via `LocalStorageClient` (SharedPreferences, FlutterSecureStorage)
- **Persistent Data**: Stored in Drift database

### How UI State Flows

1. View calls `viewModel.bind(context)` on initialization
2. ViewModel initializes Commands and fetches initial data
3. ViewModel calls `notifyListeners()` when state changes
4. View rebuilds via `ListenableBuilder`

### How Business Logic is Triggered

1. User interaction triggers a ViewModel method
2. ViewModel executes appropriate Command
3. Command invokes Use Case
4. Use Case coordinates with Repository
5. Result propagates back through ViewModel to UI

---

## Data Flow

### End-to-End Flow

```
┌──────────────────────────────────────────────────────────────────────┐
│                           USER INTERACTION                            │
└─────────────────────────────────┬────────────────────────────────────┘
                                  │
                                  ▼
┌──────────────────────────────────────────────────────────────────────┐
│                              VIEW                                     │
│  • Captures user input                                                │
│  • Calls ViewModel method                                             │
└─────────────────────────────────┬────────────────────────────────────┘
                                  │
                                  ▼
┌──────────────────────────────────────────────────────────────────────┐
│                            VIEWMODEL                                  │
│  • Executes Command                                                   │
│  • Manages UI state                                                   │
│  • Calls notifyListeners() on state change                            │
└─────────────────────────────────┬────────────────────────────────────┘
                                  │
                                  ▼
┌──────────────────────────────────────────────────────────────────────┐
│                            USE CASE                                   │
│  • Encapsulates single business operation                             │
│  • Coordinates repository calls                                       │
└─────────────────────────────────┬────────────────────────────────────┘
                                  │
                                  ▼
┌──────────────────────────────────────────────────────────────────────┐
│                           REPOSITORY                                  │
│  • Checks network connectivity                                        │
│  • Decides local vs remote data source                                │
│  • Yields local data first, then remote (Streams)                     │
└────────────┬────────────────────────────────────────┬────────────────┘
             │                                        │
             ▼                                        ▼
┌────────────────────────┐              ┌────────────────────────────┐
│   LOCAL DATASOURCE     │              │    REMOTE DATASOURCE       │
│   (Drift Database)     │              │    (Dio HTTP Client)       │
└────────────────────────┘              └────────────────────────────┘
```

### Repository Pattern

Repositories yield data as Streams, emitting local data first for immediate UI responsiveness, then fetching and emitting remote data:

```dart
// Example from HoldsRepositoryImpl
Stream<Result<List<Hold>>> getHolds({...}) async* {
  final isConnected = await networkInfoRepository.isConnected;
  final localResult = await holdsLocalDatasource.getHolds(userId: userId);
  
  yield localResult;  // Emit local data immediately
  
  if (isConnected == true) {
    // Fetch from remote, save locally, emit again
    final remoteResult = await holdsRemoteDatasource.getHolds(...);
    await holdsLocalDatasource.saveHolds(allHolds);
    yield Result.success(allHolds);
  }
}
```

---

## Online / Offline Support

The application is designed for offline-first operation with automatic sync when connectivity is restored.

### Local Persistence Strategy

**Database**: Drift (SQLite wrapper) with tables for:
- `LocalHolds` - Held orders
- `LocalCustomers` - Customer records
- `LocalSales` - Completed sales
- `LocalProducts`, `LocalProductCategories` - Product catalog
- `LocalAttendants`, `LocalWarehouses`, `LocalBarTables` - Reference data
- `LocalRegisters` - Register state

### Sync State Tracking

Each syncable entity has tracking fields:

| Field | Purpose |
|-------|---------|
| `isSynced` | Boolean flag indicating if record has been synced to server |
| `lastSyncedAt` | Timestamp of last successful sync |
| `createdLocallyAt` | Timestamp of local creation (for unsynced records) |

Example from `LocalHolds` table:
```dart
BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
DateTimeColumn get lastSyncedAt => dateTime().nullable()();
DateTimeColumn get createdLocallyAt => dateTime().nullable()();
```

Note: Some syncable entities contain only `isSynced` and `lastSyncedAt` fields or only `isSynced` field.


### Offline Action Storage

When offline:
1. Create operations store data locally with `isSynced = false`
2. Delete operations store affected IDs in `DeletedHoldIdsDatasource` for later sync

### Sync on Connectivity Restore

The `SpotstockNetworkAwareViewModel` listens for connectivity changes:

```dart
_networkSubscription = _listenForNetworkChange.call().listen((isConnected) {
  if (isConnected) {
    syncOfflineDataCommand?.execute();
  }
});
```

`SyncOfflineData` orchestrates multiple sync tasks:
```dart
class SyncOfflineData {
  final List<SpotstockSyncTaskUsecase> tasks;
  
  Stream<SyncEvent> call() async* {
    yield SyncStarted();
    for (final task in tasks) {
      yield SyncTaskStarted(task.name);
      final result = await task.sync();
    }
    yield SyncCompleted();
  }
}
```

Currently synced entities:
- `SyncHolds` - Sync unsynced holds to server
- `SyncDeletedHolds` - Delete remotely items marked for deletion while offline
- `SyncCustomers` - Sync locally created customers

---

## Reusable Components

All reusable UI components are located in `lib/core/presentation/`:

| Directory | Components |
|-----------|------------|
| `appbars/` | `SpotstockAppbar` - Consistent app bar styling |
| `banners/` | Network status banners |
| `bottom_sheets/` | Bottom sheet templates with `SpotstockBottomSheetMixin` |
| `buttons/` | `SpotstockPrimaryButton`, `SpotstockSecondaryButton`, `SpotstockFloatingActionButton`, `SpotstockIconButton` |
| `chips/` | Selection chips |
| `colors/` | Color constants and utilities |
| `dates/` | Date formatting extensions |
| `dialogs/` | Dialog templates with `SpotstockDialogMixin` |
| `dropdowns/` | Dropdown components |
| `extensions/` | Widget extensions |
| `haptic_feedback/` | Haptic feedback utilities |
| `input_validation/` | Form validation helpers |
| `logo/` | App logo widget |
| `progress_indicators/` | Loading indicators |
| `snackbars/` | Snackbar utilities with `SpotstockSnackbarMixin` |
| `symbols/` | Icon/symbol components |
| `textfields/` | Text input components |
| `view_models/` | Base ViewModel classes (`SpotstockViewModel`, `SpotstockFormViewModel`) |
| `views/` | Base view wrappers |

### Usage Principles

1. **Mixins for Side Effects**: ViewModels use mixins for dialogs, snackbars, and bottom sheets:
   ```dart
   class PosViewModel extends SpotstockViewModel 
     with SpotstockDialogMixin, SpotstockSnackbarMixin, SpotstockBottomSheetMixin
   ```

2. **Consistent Sizing**: All components use values from `SpotstockSizes`

3. **Theming**: Components use `Theme.of(context)` for colors and respect the current theme

---

## Setup and Running the App

### Prerequisites

| Requirement | Version |
|-------------|---------|
| Flutter     | 3.24.0 (specified in `.fvmrc`) |
| Dart SDK    | >= 3.2.0 < 4.0.0 |

FVM (Flutter Version Management) is recommended for version consistency.

### Installation

1. **Clone the repository**

2. **Install Flutter version** (if using FVM):
   ```bash
   fvm install
   fvm use
   ```

3. **Install dependencies**:
   ```bash
   flutter pub get
   ```

4. **Generate code** (Freezed models, Drift database):
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

### Running the App

**Debug mode**:
```bash
flutter run
```

**Specific platform**:
```bash
flutter run -d ios
flutter run -d android
flutter run -d macos
flutter run -d windows
```

### Key Dependencies

| Package | Purpose |
|---------|---------|
| `get_it` | Dependency injection (service locator) |
| `go_router` | Declarative routing |
| `drift` / `drift_flutter` | Local SQLite database |
| `dio` | HTTP client |
| `connectivity_plus` | Network connectivity monitoring |
| `freezed_annotation` | Immutable models with code generation |
| `flutter_secure_storage` | Secure credential storage |
| `shared_preferences` | Key-value storage |
| `pdf` / `printing` | Receipt generation and printing |
| `webview_flutter` | Embedded web views |

---

## Project Conventions

### Naming Conventions

| Type | Convention | Example |
|------|------------|---------|
| Files | `snake_case` | `pos_view_model.dart` |
| Classes | `PascalCase` | `PosViewModel` |
| Variables/Methods | `camelCase` | `getProductsCommand` |
| Private members | Prefix with `_` | `_products` |
| Constants | `camelCase` or `SCREAMING_SNAKE_CASE` | `SpotstockStrings.EMPTY` |

### Prefix Convention

All shared components use the `Spotstock` prefix:
- ViewModels: `SpotstockViewModel`, `SpotstockFormViewModel`
- UI Components: `SpotstockPrimaryButton`, `SpotstockAppbar`
- Strings: `SpotstockStrings`

### File Organization

Each feature follows this structure:
```
feature_name/
├── constants/           # Feature-specific constants (optional)
├── data/
│   ├── datasources/
│   │   ├── local/       # Drift-based data sources
│   │   └── remote/      # Dio-based data sources
│   ├── enums/           # Data layer enums (optional)
│   ├── mappers/         # Model transformations (optional)
│   ├── models/          # DTOs and data models
│   └── repositories/    # Repository implementations
├── domain/
│   ├── errors/          # Domain-specific errors (optional)
│   ├── repositories/    # Repository interfaces
│   └── usecases/        # Use case classes
├── presentation/
│   ├── view/            # Screen widgets
│   ├── view_model/      # ViewModels
│   └── widget/          # Feature-specific widgets
└── services/            # Feature-specific services (optional)
```

### Adding New Features

1. Create a new directory under `lib/features/`
2. Follow the layer structure above
3. Register dependencies in `lib/core/di/di.dart`:
   - Data sources
   - Repositories
   - Use cases
   - ViewModels
4. Add routes to `lib/core/routing/router.dart`

### Architecture Rules

- **No direct dependencies on data layer from presentation** - Use cases mediate
- **Repositories are interfaces in domain, implementations in data**
- **ViewModels should not directly access data sources**
- **Use `Result<T>` for all fallible operations**
- **Use Commands for async operations in ViewModels**

---

## Testing

### Current State

The project currently has minimal test coverage. The `test/` directory has not been populated with feature tests.

### Recommended Testing Strategy

Given the Clean Architecture, the following testing approach is recommended:

**Unit Tests (Domain Layer)**:
- Test use cases in isolation with mocked repositories
- Focus on business logic validation

```dart
// Example: test/features/holds/domain/usecases/create_hold_test.dart
void main() {
  late CreateHold createHold;
  late MockHoldsRepository mockRepository;

  setUp(() {
    mockRepository = MockHoldsRepository();
    createHold = CreateHold(mockRepository);
  });

  test('should call repository with correct DTO', () async {
    // Arrange
    when(() => mockRepository.createHold(any()))
        .thenAnswer((_) async => Result.success(mockHold));
    
    // Act
    final result = await createHold(createHoldDto);
    
    // Assert
    expect(result, isA<Success>());
    verify(() => mockRepository.createHold(createHoldDto)).called(1);
  });
}
```

**Integration Tests (Data Layer)**:
- Test repository implementations with mocked data sources
- Verify correct coordination between local and remote sources

**Widget Tests (Presentation Layer)**:
- Test ViewModels with mocked use cases
- Test widgets with mocked ViewModels

**Recommended Packages**:
- `mocktail` for mocking
- `bloc_test` patterns adapted for ChangeNotifier testing
- `integration_test` for end-to-end tests

---

## Future Work / Roadmap

### Desktop UI Implementation
The application architecture supports desktop platforms (macOS, Windows, Linux), but desktop-specific views have not been implemented. The routing infrastructure is prepared:

```dart
// lib/core/routing/router.dart
static final desktopRouter = GoRouter(
  routes: [],  // Desktop routes to be implemented
);
```

### Suggested Enhancements

- **Desktop Views**: Implement responsive layouts optimized for larger screens
- **Background Sync**: Implement WorkManager/background_fetch for sync when app is backgrounded
- **Comprehensive Testing**: Add unit, widget, and integration tests
- **Error Reporting**: Integrate crash reporting (e.g., Sentry, Firebase Crashlytics)
- **Offline Queue**: Implement a more robust offline queue with retry logic and conflict resolution

---

## License

[Add license information here]
