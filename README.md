# Learning App 📚

A modern Flutter-based mobile application for online learning, allowing users to discover, enroll in, and complete courses/events with feedback capabilities.

## 📱 Features

### User Authentication
- Email/Password Login
- Google Sign-In Integration
- Facebook Sign-In Integration
- Forgot Password Functionality
- New User Registration

### Home & Course Discovery
- Browse available courses and events
- View "Free Time" and "Continued" courses
- Explore recommended courses
- Real-time search functionality
- Course categorization

### Course/Event Details
- Comprehensive course information
- Instructor details
- Course sections and content breakdown
- Star-based rating system
- Submit course feedback and reviews
- View other users' ratings and feedback

### Profile & Settings
- User profile management
- Account settings
- Notification preferences
- Payment methods management
- Privacy policy access
- Help & support
- Secure logout

### Notifications
- Push notifications for new courses
- Course updates and announcements
- Personalized learning reminders

### Navigation
- Bottom navigation bar with:
  - Home
  - Courses
  - Saved/Bookmarks
  - Menu/Profile

## 🏗️ Project Structure

```
learning_app/
├── lib/
│   ├── main.dart                    # App entry point
│   ├── models/                      # Data models
│   │   ├── user_model.dart
│   │   ├── course_model.dart
│   │   ├── event_model.dart
│   │   ├── feedback_model.dart
│   │   └── section_model.dart
│   ├── screens/                     # UI Screens
│   │   ├── auth/                    # Authentication screens
│   │   │   ├── login_screen.dart
│   │   │   ├── signup_screen.dart
│   │   │   └── forgot_password_screen.dart
│   │   ├── home/                    # Home & discovery
│   │   │   ├── home_screen.dart
│   │   │   └── search_screen.dart
│   │   ├── course/                  # Course related
│   │   │   ├── course_list_screen.dart
│   │   │   ├── course_detail_screen.dart
│   │   │   └── feedback_screen.dart
│   │   └── profile/                 # User profile & settings
│   │       ├── profile_screen.dart
│   │       ├── settings_screen.dart
│   │       ├── notifications_screen.dart
│   │       ├── payment_methods_screen.dart
│   │       └── help_support_screen.dart
│   ├── widgets/                     # Reusable widgets
│   │   ├── course_card.dart
│   │   ├── custom_button.dart
│   │   ├── custom_text_field.dart
│   │   ├── rating_widget.dart
│   │   └── bottom_nav_bar.dart
│   ├── services/                    # Business logic & API
│   │   ├── auth_service.dart
│   │   ├── course_service.dart
│   │   ├── notification_service.dart
│   │   ├── database_service.dart
│   │   └── api_service.dart
│   └── utils/                       # Utility functions & constants
│       ├── constants.dart
│       ├── theme.dart
│       ├── validators.dart
│       └── helpers.dart
├── assets/                          # Static assets
│   ├── images/
│   │   └── (app images, logos, etc.)
│   └── icons/
│       └── (custom icons)
├── test/                            # Unit & widget tests
├── pubspec.yaml                     # Dependencies
└── README.md                        # This file
```

## 🎨 Screens Overview

### 1. Welcome Back (Login Screen)
- Email and password input fields
- "Forgot password?" link
- Login button
- Social sign-in options (Google, Facebook)
- Navigation to signup

### 2. Home Screen
- Top navigation with menu and search icons
- "The best online courses you have" header
- Course cards with thumbnails
- "Free Time" and "Continued" sections
- "Recommended Courses" section
- Bottom navigation bar

### 3. Course Details Screen
- Course thumbnail/image
- Course title
- Instructor name
- Star rating system (1-5 stars)
- "Give Feedback" button
- Section list with expandable content
- Navigation back button

### 4. Profile & Settings Screen
- User profile picture
- User name display (e.g., "John Smith")
- Settings menu:
  - Profile Information
  - Account Settings
  - Notifications
  - Payment Methods
  - Privacy Policy
  - Help & Support
- Logout button

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / VS Code
- Android/iOS device or emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd learning_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # UI & Styling
  cupertino_icons: ^1.0.2
  google_fonts: ^6.1.0
  
  # State Management
  provider: ^6.1.0
  
  # Authentication
  firebase_auth: ^5.0.0
  google_sign_in: ^6.2.1
  flutter_facebook_auth: ^7.0.0
  
  # Database & Storage
  cloud_firestore: ^5.0.0
  firebase_storage: ^12.0.0
  shared_preferences: ^2.2.3
  
  # Notifications
  firebase_messaging: ^15.0.0
  flutter_local_notifications: ^17.0.0
  
  # Network & API
  http: ^1.2.0
  dio: ^5.4.0
  
  # Others
  intl: ^0.19.0
  url_launcher: ^6.2.5

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
```

## 🔧 Configuration

### Firebase Setup
1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
2. Add Android/iOS apps to your Firebase project
3. Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
4. Place them in respective platform directories
5. Enable Authentication methods (Email, Google, Facebook)
6. Set up Cloud Firestore database
7. Configure Firebase Cloud Messaging for notifications

### Environment Variables
Create a `.env` file in the root directory:
```
API_BASE_URL=your_api_url
FIREBASE_API_KEY=your_firebase_key
```

## 📱 Features Implementation

### Authentication Flow
- Email/Password authentication with validation
- OAuth integration for Google and Facebook
- Password reset functionality
- Persistent login sessions

### Course Management
- Fetch courses from backend API
- Display course cards with images and metadata
- Filter and search functionality
- Bookmark/Save courses for later
- Track course progress

### Feedback System
- 5-star rating system
- Text feedback submission
- View aggregated ratings
- Instructor response capability

### Notification System
- Push notifications for new courses
- In-app notification center
- Customizable notification preferences
- Badge indicators for unread notifications

## 🎯 User Flow

1. **First Time User**
   - Launch app → Signup screen
   - Create account with email or social login
   - Complete profile setup
   - Browse courses on home screen

2. **Returning User**
   - Launch app → Login screen
   - Enter credentials or use social login
   - Access home screen with personalized content
   - Continue learning from saved courses

3. **Course Enrollment & Learning**
   - Browse courses on home screen
   - Tap course card → View course details
   - Read course description and sections
   - Enroll in course
   - Complete course sections
   - Submit feedback and rating

4. **Profile Management**
   - Access profile from bottom navigation
   - Update personal information
   - Manage notification settings
   - Add/update payment methods
   - Logout when needed

## 🛠️ Development Guidelines

### Code Style
- Follow Flutter/Dart style guide
- Use meaningful variable and function names
- Add comments for complex logic
- Keep functions small and focused

### State Management
- Use Provider for state management
- Separate business logic from UI
- Implement proper error handling

### API Integration
- Centralize API calls in service classes
- Handle network errors gracefully
- Implement proper loading states
- Cache data when appropriate

### Testing
- Write unit tests for business logic
- Create widget tests for UI components
- Implement integration tests for critical flows

## 🔐 Security Considerations
- Store sensitive data securely (tokens, passwords)
- Implement proper authentication checks
- Validate all user inputs
- Use HTTPS for all API calls
- Follow OWASP mobile security guidelines

## 📊 Database Schema

### Users Collection
```json
{
  "uid": "string",
  "email": "string",
  "displayName": "string",
  "photoURL": "string",
  "createdAt": "timestamp",
  "enrolledCourses": ["courseId1", "courseId2"],
  "savedCourses": ["courseId1"],
  "notificationPreferences": {
    "newCourses": true,
    "courseUpdates": true,
    "reminders": true
  }
}
```

### Courses Collection
```json
{
  "courseId": "string",
  "title": "string",
  "description": "string",
  "instructor": {
    "name": "string",
    "bio": "string",
    "photoURL": "string"
  },
  "thumbnail": "string",
  "category": "string",
  "sections": [
    {
      "sectionId": "string",
