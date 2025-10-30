# MADG28 - Course Management App

![App Logo](assets/images/logo.png)

## Description

MADG28 is a Flutter-based mobile application designed for managing and exploring online courses. It provides a user-friendly interface for browsing available courses, viewing detailed course information, enrolling in courses, and submitting feedback on individual lessons. The app aims to offer a seamless learning experience with features like skeleton loading for better UX, robust form validations, and personalized profile management.

## Features

- **User Authentication:** Secure login and signup with email (Gmail only) and password, including strong password validation rules.
- **Social Login:** Option to continue with Google or Facebook (placeholder functionality).
- **Course Listing:** Browse a list of available courses with essential details like name, instructor, and rating.
- **Course Detail View:** Detailed view for each course, including description, learning outcomes, instructor, level, duration, and overall rating.
- **Lesson Management:** Courses are broken down into individual lessons, each with a title and duration.
- **Feedback System:** Users can submit star ratings and written feedback for each lesson, similar to Google Play Store reviews.
- **Enrolled Courses:** Users can enroll in courses, and a dedicated screen displays all enrolled courses with progress tracking.
- **Profile Management:** Users can view their profile, change their profile picture (using the device's gallery), and manage settings.
- **Theme Switching:** Toggle between light and dark modes.
- **Notifications Management:** Enable or disable in-app notifications.
- **Language Selection:** Option to select app language (placeholder functionality).
- **Skeleton Loading:** Enhanced user experience with skeleton loading indicators while data is being fetched.
- **Responsive UI:** Designed to adapt to various screen sizes and orientations.

## Screenshots

*(Screenshots will be added here to showcase the application's features and UI.)*

## Installation

To get a local copy up and running, follow these simple steps.

### Prerequisites

- Flutter SDK installed (version 3.9.0 or higher recommended)
- Dart SDK (comes with Flutter)
- Android Studio or VS Code with Flutter and Dart plugins
- A physical device or emulator/simulator for running the app

### Setup

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/your-username/madg28.git
    cd madg28
    ```
2.  **Get dependencies:**
    ```bash
    flutter pub get
    ```
3.  **Run the application:**
    ```bash
    flutter run
    ```
    (Ensure you have a device or emulator connected and running.)

## Usage

- **Login/Signup:** Create a new account or log in with existing credentials. Password must meet strong validation criteria.
- **Browse Courses:** Navigate through the list of available courses on the home screen.
- **View Course Details:** Tap on any course to see its detailed description, lessons, and other information.
- **Enroll in a Course:** On the course detail page, click the "Enroll Course" button to add it to your enrolled list.
- **Leave Feedback:** Within each lesson's expanded view on the course detail page, you can submit a star rating and a comment.
- **Enrolled Courses:** Access your enrolled courses from the home screen's app bar (school icon) to view your progress.
- **Profile & Settings:** Manage your profile picture, toggle dark mode, and adjust notification settings from the profile screen.

## Project Structure

```
madg28/
├── lib/
│   ├── main.dart                 # Main entry point of the application
│   ├── theme_notifier.dart       # Manages theme switching (light/dark mode)
│   ├── models/                   # Data models (Program, Lesson, Feedback, EnrolledCourse)
│   │   ├── mockapi.dart          # Mock API service for data fetching and manipulation
│   │   └── program.dart          # Defines data structures for courses and related entities
│   ├── notifiers/                # ChangeNotifier classes for state management
│   │   ├── program_detail_notifier.dart # Manages state for course detail screen
│   │   └── programs_notifier.dart       # Manages state for program listing screen
│   ├── screens/                  # UI screens of the application
│   │   ├── program_detail_screen.dart   # Displays detailed course information
│   │   ├── course/                      # Course-related screens
│   │   │   └── enrolled_courses_screen.dart # Displays courses the user has enrolled in
│   │   ├── home/                        # Home screen
│   │   │   └── program_listing.dart     # Lists all available programs
│   │   ├── login/                       # Login screen
│   │   │   └── login_screen.dart
│   │   ├── profile_and_settings/        # User profile and settings screen
│   │   │   └── profile_and_settings_screen.dart
│   │   ├── search/                      # Search screen
│   │   │   └── search_screen.dart
│   │   └── signup/                      # Signup screen
│   │       └── signup_screen.dart
│   └── widgets/                  # Reusable UI widgets
│       ├── custom_password_field.dart   # Custom password input field with toggle visibility
│       └── social_login_button.dart     # Button for social media logins
├── assets/
│   ├── data/
│   │   └── programs.json         # Mock data for courses
│   └── images/
│       ├── advance_flutter.png   # Image used in profile background
│       ├── facebook.png          # Facebook login icon
│       ├── google.png            # Google login icon
│       ├── logo.png              # App logo
│       └── placeholder.png       # Placeholder image for skeleton loading
├── pubspec.yaml                  # Project dependencies and metadata
└── README.md                     # Project documentation
```

## Dependencies

- `flutter`: The UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
- `cupertino_icons`: iOS-style icons for Flutter.
- `google_nav_bar`: A beautiful and customizable Google style navigation bar for Flutter.
- `provider`: A simple yet powerful state management solution for Flutter.
- `shared_preferences`: Persistent storage for simple data.
- `skeletonizer`: A Flutter package that converts already built widgets into skeleton loaders with no extra effort.
- `flutter_rating_bar`: A Flutter widget to show a rating bar.
- `image_picker`: A Flutter plugin for iOS, Android, and Web that allows you to pick images from the image library, or to take new pictures with the camera.

## Future Enhancements

- **Backend Integration:** Replace mock API with a real backend for persistent data storage and user management.
- **User-Specific Data:** Implement actual user authentication and store user-specific enrolled courses and feedback.
- **Advanced Search:** Implement more robust search functionality with filters and sorting.
- **Course Progress Tracking:** More detailed tracking of lesson completion and overall course progress.
- **Push Notifications:** Implement real-time notifications for course updates, new feedback, etc.
- **Offline Support:** Allow users to access course content and track progress offline.
- **Payment Gateway Integration:** For paid courses.
- **Instructor Dashboard:** A separate section for instructors to manage their courses and view feedback.

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue.

## License

This project is licensed under the MIT License - see the LICENSE file for details. (Note: A LICENSE file should be created in the root directory of the project.)