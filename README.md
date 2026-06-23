# Chatting App

A modern, real-time Flutter chat application supporting peer-to-peer 1-on-1 messaging, clean authentication, and sleek modern aesthetics.

---

## 🚀 Features

- **P2P 1-on-1 Direct Messaging**: Chat in real-time with any registered user. Message rooms are derived uniquely between users.
- **Custom User Profiles**: Register with a unique username saved in Cloud Firestore.
- **Smooth Form Validation & Focus**: Real-time validation for email/password formatting with automated keyboard focus shifting (`next` / `done` text input actions).
- **Modern Theme & Styling**: Sleek Slate, Cyan, and Indigo color palette with custom-built text form fields, send/receive bubbles, and actions.
- **Real-Time Data Streaming**: Powered by Firestore streams to update the UI instantly on message arrival.

---

## 🛠️ Tech Stack & Dependencies

- **Framework**: [Flutter](https://flutter.dev) (Dart SDK)
- **Database**: [Cloud Firestore](https://firebase.google.com/docs/firestore) (real-time message sub-collections)
- **Authentication**: [Firebase Authentication](https://firebase.google.com/docs/auth) (email & password login)
- **Design Language**: Modern Material Design themed with customized Tailwind-like slate color tokens.

---

## 📁 Project Directory Structure

```
lib/
├── helper/
│   └── snack_bar.dart        # Helper for snackbar alerts
├── models/
│   └── message.dart          # Message model for parsing Firestore data
├── views/
│   ├── home_view.dart        # Landing page
│   ├── login_view.dart       # Authentication: Login view
│   ├── register_view.dart    # Authentication: Registration view
│   ├── users_view.dart       # Active direct message conversations list
│   └── chat_view.dart        # Direct messaging screen
├── widgets/
│   ├── custom_text_button.dart
│   ├── custom_text_form_field.dart
│   ├── main_button.dart
│   ├── recieve_chat_bubble.dart
│   └── send_chat_bubble.dart
├── constants.dart            # Central color tokens, assets, and collection keys
├── firebase_options.dart     # Auto-generated Firebase configurations
└── main.dart                 # Application entry point & routing configuration
```

---

## ⚙️ Setup & Installation

1. **Prerequisites**: Ensure you have the Flutter SDK installed on your system.
2. **Clone the Repository**:
   ```bash
   git clone <repository-url>
   cd chatting_app
   ```
3. **Get Packages**:
   ```bash
   flutter pub get
   ```
4. **Firebase Configuration**:
   - Ensure the Firebase project is configured on your system using the FlutterFire CLI, or update the existing `firebase_options.dart` to match your project settings.
5. **Run the App**:
   ```bash
   flutter run
   ```
