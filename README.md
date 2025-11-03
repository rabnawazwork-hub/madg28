# MADG28 - Online Learning Platform

This is a Flutter-based online learning platform that provides users with a rich and interactive learning experience. The application allows users to browse a wide range of courses, enroll in them, track their progress, and interact with the course content. The app features a clean and modern user interface, with support for both light and dark themes, as well as localization for multiple languages.

## 🚀 Features

-   **User Authentication:** Secure login and signup functionality for users to access the platform.
-   **Mock Social Login:** Mock Google and Facebook login for a realistic user experience.
-   **Course Catalog:** A comprehensive list of available courses with detailed descriptions, instructors, and ratings.
-   **Course Enrollment:** Users can enroll in courses they are interested in and track their progress.
-   **Detailed Course View:** A detailed view for each course, including a list of lessons, what you will learn, and user feedback.
-   **Search Functionality:** Users can easily search for courses based on keywords.
-   **User Profile:** A dedicated screen for users to view and edit their profile information.
-   **Enrolled Courses:** A list of all the courses a user is currently enrolled in, with progress tracking.
-   **Data Persistence:** User data, theme, and language preferences are saved across app restarts using `shared_preferences`.
-   **Localization:** Support for multiple languages, including English, Spanish, French, and German.
-   **Light & Dark Theme:** The app supports both light and dark themes for a comfortable viewing experience.


## 🛠️ Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

-   Flutter SDK: Make sure you have the Flutter SDK installed on your machine. For more information, see the [Flutter documentation](https://flutter.dev/docs/get-started/install).
-   Dart: The project is written in Dart, which is included with the Flutter SDK.

### Installation

1.  **Clone the repository:**
    ```sh
    git clone https://github.com/your_username/madg28.git
    ```
2.  **Navigate to the project directory:**
    ```sh
    cd madg28
    ```
3.  **Install dependencies:**
    ```sh
    flutter pub get
    ```
4.  **Run the app:**
    ```sh
    flutter run
    ```

## 📦 Dependencies

The project uses the following dependencies:

-   `flutter`: The core Flutter framework.
-   `image_picker`: For picking images from the gallery or camera.
-   `language_picker`: For selecting a language from a list of supported languages.
-   `flutter_localizations`: For localization support.
-   `intl`: For internationalization and localization.
-   `cupertino_icons`: For iOS-style icons.
-   `google_nav_bar`: For the bottom navigation bar.
-   `provider`: For state management.
-   `shared_preferences`: For storing simple data.
-   `skeletonizer`: For creating loading skeletons.
-   `flutter_rating_bar`: For displaying rating bars.

For a full list of dependencies, see the `pubspec.yaml` file.

##  Mocking

This application uses a mock API and mock authentication for demonstration purposes. The course data is loaded from a local JSON file, and the login functionality is simulated to provide a realistic user experience without requiring a backend.

## 📁 Project Structure

The project follows a standard Flutter project structure, with the following key directories:

-   `lib/`: The main source code of the application.
    -   `main.dart`: The entry point of the application.
    -   `models/`: Contains the data models for the application (e.g., `Program`, `Lesson`).
    -   `notifiers/`: Contains the change notifiers for state management (e.g., `ProgramsNotifier`, `ProgramDetailNotifier`).
    -   `providers/`: Contains the providers for managing the app's state (e.g., `LocaleProvider`, `UserProvider`).
    -   `screens/`: Contains the different screens of the application (e.g., `LoginScreen`, `ProgramListingScreen`).
    -   `widgets/`: Contains reusable widgets used throughout the application.
    -   `l10n/`: Contains the localization files for different languages.
-   `assets/`: Contains the static assets of the application, such as images and data files.
-   `test/`: Contains the tests for the application.
## Screenshots

![Screenshot_20251103-194822](https://github.com/user-attachments/assets/7c9a5a05-e0e9-49b7-a6af-6405b85d3bff)
![Screenshot_20251103-194826](https://github.com/user-attachments/assets/4c030375-d832-48ee-9976-8d3d688e19b5)
![Screenshot_20251103-194920](https://github.com/user-attachments/assets/c7017ace-e759-4f79-b47d-2ec86f68f383)
<img width="275" height="484" alt="home" src="https://github.com/user-attachments/assets/717fbf81-2dc9-4c58-8d93-cf58b82e8fb6" />
<img width="270" height="487" alt="details" src="https://github.com/user-attachments/assets/1a7a1bce-a44e-480c-9a48-6fc117ac9eeb" />
<img width="275" height="485" alt="image" src="https://github.com/user-attachments/assets/de6bb8d4-9f97-42b3-8a91-506339962532" />
<img width="273" height="488" alt="image" src="https://github.com/user-attachments/assets/be18a599-615d-4f1d-a5dc-3b5a44447018" />
![Screenshot_20251103-194920](https://github.com/user-attachments/assets/5e935a05-2033-4dcf-b3a0-0b5694c31ae0)
![Screenshot_20251103-194936](https://github.com/user-attachments/assets/a72eaefc-83ac-4448-963c-d246c814e887)
![Screenshot_20251103-194945](https://github.com/user-attachments/assets/e6646950-ce91-4b48-b66a-d019cfbfd338)


## 🌐 State Management

The project uses the `provider` package for state management. This allows for a clean and efficient way to manage the application's state, with a clear separation of concerns between the UI and the business logic.

## 🌍 Localization

The application supports multiple languages through the `flutter_localizations` and `intl` packages. The localization files are located in the `lib/l10n` directory, and the `LocaleProvider` is used to manage the current locale of the app.

## 🎨 Theming

The application supports both light and dark themes, which can be switched dynamically. The `ThemeNotifier` is used to manage the current theme of the app, and the theme data is defined in the `main.dart` file.

## 🤝 Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".

1.  Fork the Project
2.  Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3.  Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4.  Push to the Branch (`git push origin feature/AmazingFeature`)
5.  Open a Pull Request
