# PokeApp 📱

A modern, feature-rich Pokedex application built with Flutter, demonstrating Clean Architecture, BLoC state management, and offline capabilities.

![PokeApp Banner](https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/poke-ball.png) <!-- Replace with actual banner if available -->

## ✨ Features

- **Pokemon List**: Browse a comprehensive list of Pokemon with infinite scrolling pagination.
- **Search**: Instantly search for Pokemon by name or ID.
- **Detailed View**: View detailed information including stats, physical attributes, types, and stats.
- **Offline Support**: Browse previously visited content even without an internet connection using Hive caching.
- **Connectivity Handling**: Real-time network status monitoring with user feedback.
- **Responsive Design**: Optimized for different screen sizes.

## 📸 Screenshots

| Home | Search | Detail | Evolutions |
|:---:|:---:|:---:|:---:|
| <img src="assets/screenshots/home.png" width="200" /> | <img src="assets/screenshots/search.png" width="200" /> | <img src="assets/screenshots/detail.png" width="200" /> | <img src="assets/screenshots/evolutions.png" width="200" /> |

## 🛠️ Tech Stack & Architecture

This project follows **Clean Architecture** principles to ensure separation of concerns, testability, and scalability.

- **Language**: [Dart](https://dart.dev/)
- **Framework**: [Flutter](https://flutter.dev/)
- **State Management**: [flutter_bloc](https://pub.dev/packages/flutter_bloc) (Cubit)
- **Architecture**: Clean Architecture (Presentation, Domain, Data layers)
- **Navigation**: [go_router](https://pub.dev/packages/go_router)
- **Networking**: [dio](https://pub.dev/packages/dio) with [internet_connection_checker_plus](https://pub.dev/packages/internet_connection_checker_plus)
- **Local Storage**: [hive](https://pub.dev/packages/hive)
- **Dependency Injection**: [get_it](https://pub.dev/packages/get_it)
- **Testing**: [mocktail](https://pub.dev/packages/mocktail), [bloc_test](https://pub.dev/packages/bloc_test)

## 📂 Project Structure

```
lib/
├── core/                   # Core functionality (DI, Network, Config, Shared Widgets)
├── features/               # Feature-based modules
│   ├── pokemon_list/       # List feature (Data, Domain, Presentation, Services)
│   └── pokemon_detail/     # Detail feature (Data, Domain, Presentation, Services)
└── main.dart               # Entry point
```

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (latest stable version recommended)
- [Dart SDK](https://dart.dev/get-dart)

### Installation

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/laraveloper96/flutterPokeApp.git
    cd flutterPokeApp
    ```

2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```

3.  **Run code generation**:
    This project uses code generation for JSON serialization and Hive adapters.
    ```bash
    dart run build_runner build -d
    ```

### ▶️ Running the App

The application requires environment variables to be defined for API endpoints.

**Using default PokeAPI:**

```bash
flutter run --dart-define=BASE_URL=https://pokeapi.co/api/v2/ --dart-define=BASE_URL_IMAGE=https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/
```

| Variable | Description | Example Value |
| :--- | :--- | :--- |
| `BASE_URL` | The Base URL for the Pokemon API | `https://pokeapi.co/api/v2/` |
| `BASE_URL_IMAGE` | Base URL for fetching Pokemon images | `https://raw.githubusercontent.com...` |

## 🧪 Testing

To run unit and widget tests:

```bash
flutter test
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1.  Fork the project
2.  Create your feature branch (`git checkout -b feature/AmazingFeature`)
3.  Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4.  Push to the branch (`git push origin feature/AmazingFeature`)
5.  Open a Pull Request
