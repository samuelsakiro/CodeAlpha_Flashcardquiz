# Flashcard Quiz App

A modern Flutter application for creating and managing flashcards with a clean architecture structure and Provider state management.

## Features

- ✅ Create, edit, and delete flashcards
- ✅ Navigate between flashcards with intuitive controls
- ✅ Toggle between question and answer views
- ✅ Persistent storage using Hive database
- ✅ Clean architecture with separation of concerns
- ✅ Provider state management
- ✅ Material Design 3 UI
- ✅ Responsive design

## Architecture

This app follows Clean Architecture principles with the following structure:

```
lib/
├── core/                    # Core domain layer
│   ├── entities/           # Business entities
│   └── repositories/       # Repository interfaces
├── data/                   # Data layer
│   └── repositories/       # Repository implementations
├── presentation/           # Presentation layer
│   ├── providers/         # State management
│   ├── screens/           # UI screens
│   └── widgets/           # Reusable UI components
└── main.dart              # App entry point
```

### Core Layer
- **Entities**: Business objects (Flashcard)
- **Repositories**: Abstract interfaces for data operations

### Data Layer
- **Repositories**: Concrete implementations (HiveFlashcardRepository)
- Handles data persistence and retrieval

### Presentation Layer
- **Providers**: State management using Provider package
- **Screens**: Main UI screens
- **Widgets**: Reusable UI components

## Getting Started

### Prerequisites
- Flutter SDK (3.7.2 or higher)
- Dart SDK
- Android Studio / VS Code

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd flashcardquiz
```

2. Install dependencies:
```bash
flutter pub get
```

3. Generate Hive adapters:
```bash
flutter packages pub run build_runner build
```

4. Run the app:
```bash
flutter run
```

## Dependencies

- **flutter**: Core Flutter framework
- **provider**: State management
- **hive**: Local database
- **hive_flutter**: Flutter integration for Hive
- **uuid**: Unique ID generation
- **path_provider**: File system access

## Usage

### Adding Flashcards
1. Tap the floating action button (+)
2. Enter question and answer
3. Tap "Add" to save

### Navigating Flashcards
- Use arrow buttons to navigate between cards
- Tap "Show Answer" to reveal the answer
- Tap "Show Question" to go back to the question

### Editing Flashcards
1. Navigate to the desired flashcard
2. Tap the edit button (pencil icon)
3. Modify question or answer
4. Tap "Save"

### Deleting Flashcards
1. Navigate to the desired flashcard
2. Tap the delete button (trash icon)
3. Confirm deletion

## State Management

The app uses Provider for state management with a single `FlashcardProvider` that handles:
- Flashcard CRUD operations
- Navigation state
- UI state (show/hide answers)
- Loading states

## Database

The app uses Hive for local storage, which provides:
- Fast NoSQL database
- Type-safe operations
- Automatic serialization
- Cross-platform compatibility

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License.

## Screenshots

[Add screenshots here when available]

## Future Enhancements

- [ ] Categories/tags for flashcards
- [ ] Search functionality
- [ ] Import/export flashcards
- [ ] Study statistics
- [ ] Dark mode support
- [ ] Offline sync
- [ ] Multiple choice questions
- [ ] Spaced repetition algorithm 