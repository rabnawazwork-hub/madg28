# 4excelerate Learning App 📚

A Flutter-based mobile application for browsing online courses, branded for the 4excelerate organization.

## 📱 Features

This is a simple app that demonstrates the following features:

*   **Branding:** The app is branded with the 4excelerate.org logo and color scheme.
*   **Program Listing:** Fetches and displays a list of programs from a mock API.
*   **Program Details:** Shows the details of a selected program, including its lessons.
*   **Profile Screen:** A basic profile screen.
*   **Settings Screen:** A basic settings screen.
*   **Bottom Navigation:** A bottom navigation bar to switch between the home and profile screens.

## 🏗️ Project Structure

```
.
├── lib
│   ├── main.dart
│   ├── models
│   │   ├── mockapi.dart
│   │   └── program.dart
│   ├── screens
│   │   ├── course
│   │   │   └── program_details.dart
│   │   ├── home
│   │   │   └── program_listing.dart
│   │   ├── profile
│   │   │   └── profile_screen.dart
│   │   └── settings
│   │       └── settings_screen.dart
│   └── widgets
├── assets
│   └── images
│       └── logo.png
├── pubspec.yaml
└── README.md
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK
- Dart SDK
- An editor like Android Studio or VS Code
- An Android/iOS device or emulator

### Installation

1.  **Clone the repository**
2.  **Install dependencies**
    ```bash
    flutter pub get
    ```
3.  **Run the app**
    ```bash
    flutter run
    ```
