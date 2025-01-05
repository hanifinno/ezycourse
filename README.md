# EzyCourse App

**EzyCourse App** is a Flutter-based community application developed as a test project by AppifyLab. It facilitates learning and interaction between students and teachers. Users can stay updated with their courses and engage in discussions within the community.

---

## Features

- **Community Engagement**: Students can interact with teachers and peers in a shared community space.
- **Course Updates**: Stay informed with the latest updates on your courses.
- **Commenting & Reactions**: Post comments, react to posts, and engage with community content.
- **Create Posts**: Users can create and share posts with text, images, or backgrounds.
- **Real-time Notifications**: Keep track of community activities in real-time.

---

## Getting Started

### Prerequisites

- Install [Flutter](https://flutter.dev/docs/get-started/install).
- Install [Dart](https://dart.dev/get-dart).
- Install an IDE such as [Android Studio](https://developer.android.com/studio) or [Visual Studio Code](https://code.visualstudio.com/).

---

### Project Setup

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-repo/ezycourse.git](https://github.com/hanifinno/ezycourse)
   cd ezycourse
   ```

2. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

3. **Update Configurations**:
   Update the `android/app/src/main/AndroidManifest.xml` file with the necessary permissions:
   ```xml
   <uses-permission android:name="android.permission.INTERNET" />
   <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
   <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
   ```

4. **Set Up Firebase (Optional)**:
   If your app uses Firebase for authentication or notifications:
   - Download your `google-services.json` file for Android and place it in the `android/app` directory.
   - Follow [Firebase setup](https://firebase.google.com/docs/flutter/setup) for Flutter.

---


## Development Environment

- **Flutter SDK**: '>=3.3.0 <4.0.0'
- **Android SDK**: (Android SDK version 35.0.0)
- **Version**: version: 1.0.0+1
- **Dart SDK**: 2.x or above
- **State Management**: [GetX](https://pub.dev/packages/get)
- **UI Framework**: Material Design

---

## Folder Structure

```plaintext
lib/
├── components/        # Reusable widgets and UI components
├── config/            # Application configuration and constants
├── data/              # Mock data and data models
├── models/            # Dart models for API responses and business logic
├── modules/           # App modules (Home, Profile, etc.)
└── utils/             # Utility functions and helpers
```

---

## Contribution

If you wish to contribute:
1. Fork the repository.
2. Create a new branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add your message here"
   ```
4. Push your branch:
   ```bash
   git push origin feature/your-feature-name
   ```
5. Submit a pull request.

---
## Design(N:B):
1. I have changed login button coz i thought a gradient login button will suit
2. I have created a reaction list view as it is not in given Figma 
3. I have named the community appbar as per figma as it is not mentioned fetch community  api
4.Due to extreme workload in my office i could not manage all the design issues and some funtionality as my office has no holiday in saturday. I hope that would be conidered too.
5. I Have added A splash screen and shimmer loader for the app.
6. I will work on the issues after my office time if it is permitted.









## Contact

For inquiries or feedback, please reach out to:
- **AppifyLab**: [website](https://www.appifylab.com)

---

### Happy Coding! 🚀

