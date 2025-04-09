
# Workwise - Flutter Application

Workwise is a Flutter-based job matching platform connecting students and part-time job seekers with short-term employment opportunities. With Firebase integration for authentication, storage, and real-time features, businesses can post jobs seamlessly and hire reliable freelancers. The app simplifies hiring for roles requiring no prior experience, supporting Android, iOS, macOS, and Windows.

## Features

- Student and job seeker matching system
- Business job posting dashboard
- User authentication with Firebase
- Job posting and management
- Candidate search and application
- Real-time notifications
- Cross-platform support

## Project Structure

```
lib/
├── Controller/        # Application controllers
├── core/              # Core utilities and network
├── presentation/      # UI screens
├── resources/         # Assets, colors, dimensions
├── routes/            # App navigation
├── theme/             # Theme configurations
├── user_auth/         # Authentication implementation
└── widgets/           # Custom widgets
```

## Firebase Configuration

This project uses Firebase services across all platforms. The configuration is managed through environment variables in `.env` file.

### Required Firebase Services

- Authentication
- Firestore Database
- Cloud Storage
- Cloud Messaging

## Setup Instructions

### Prerequisites
- Flutter SDK (version 3.13.0 or higher)
- Dart SDK (version 2.18.0 or higher)
- Firebase account with project created
- Platform-specific development environments:
  - Android Studio/ VSCode (for Android)
  - Xcode (for iOS/macOS)

### Installation Steps
1. Clone the repository:
```bash
git clone https://github.com/dehkai/workwise.git
cd workwise
```

2. Install dependencies:
```bash
flutter pub get
```

3. Set up Firebase:
   - Create `.env` file from template:
```bash
cp .env.example .env
```
   - Configure Firebase credentials for all target platforms
   - Download Firebase config files:
     - `google-services.json` for Android
     - `GoogleService-Info.plist` for iOS/macOS
     - Place these in their respective platform directories

4. Platform-specific setup:
   - **Android**:
     - Set up Android SDK and emulator
     - Enable multidex in `android/app/build.gradle`
   - **iOS**:
     - Run `pod install` in `ios` directory
     - Set up signing in Xcode

5. Run the app:
```bash
flutter run
```

### Common Issues
- **Firebase not initialized**: Verify all config files are in correct locations
- **Platform not supported**: Ensure you've enabled the platform in Flutter
- **Dependency conflicts**: Run `flutter pub upgrade` to resolve
- **Build failures**: Clean project with `flutter clean` and rebuild

### Environment Variables

Copy the `.env.example` file to `.env` and fill in your Firebase credentials:

```bash
cp .env.example .env
```

Configure all platform-specific Firebase keys:
- `FIREBASE_WEB_*`
- `FIREBASE_ANDROID_*`
- `FIREBASE_IOS_*`
- `FIREBASE_MACOS_*`
- `FIREBASE_WINDOWS_*`

## Running the App

### Development Mode
```bash
flutter run
```

Select your target device when prompted. For specific platforms:
- Android: `flutter run -d android`
- iOS: `flutter run -d ios`
- macOS: `flutter run -d macos`
- Windows: `flutter run -d windows`

### Debugging Tips
- Use `flutter doctor` to check environment setup
- For hot reload: `r` in terminal after running
- For hot restart: `R` in terminal
- To view logs: `flutter logs`






