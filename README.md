# Create Smart Notes 📝

A clean, responsive note-taking mobile application built with Flutter, Provider, and Firebase. Designed with an MVVM-inspired, feature-first architecture to provide a smooth, fast, and structured user experience.

---

##  App Previews

| Login | Sign Up | Forgot Password |
| :---: | :---: | :---: |
| <img src="screenshots/login.png" width="220" /> | <img src="screenshots/signup.png" width="220" /> | <img src="screenshots/reset password.png" width="220" /> |

| Notes List & Search | Navigation Drawer | Add Note | Settings (Dark Mode) |
| :---: | :---: | :---: | :---: |
| <img src="screenshots/home page.png" width="200" /> | <img src="screenshots/logout.png" width="200" /> | <img src="screenshots/setting.png" width="200" /> | <img src="screenshots/add notes.png" width="200" /> | <img src="screenshots/my notes.png" width="200" /> |

---

##  Features

- **Authentication Flow:** Email & password authentication, account creation, and password reset via Firebase Auth.
- Full CRUD Support:** Create, read, update, and delete notes instantly synced with Cloud Firestore.
- Real-Time Search:** Search notes dynamically by title.
- Favorites & Organization:** Mark critical notes as favorites and access them quickly.
- Theme Support:** Dark mode toggle stored via Shared Preferences.
- User Profile Drawer:** Side drawer displaying account info and quick navigation.

---

##  Tech Stack & Architecture

- **Framework:** [Flutter](https://flutter.dev/) (Material 3)
- **Language:** [Dart](https://dart.dev/)
- **Backend & Cloud:** Firebase Authentication, Cloud Firestore
- **State Management:** Provider
- **Local Storage:** Shared Preferences
- **Architecture:** Feature-Driven / MVVM Separation

---

## 📂 Project Structure

```text
lib/
├── core/
│   ├── provider/
│   └── widgets/
├── features/
│   ├── auth/
│   │   ├── provider/
│   │   ├── screens/
│   │   └── services/
│   ├── notes/
│   │   ├── models/
│   │   ├── provider/
│   │   ├── screens/
│   │   ├── services/
│   │   └── widgets/
│   ├── settings/
│   └── splash/
│       └── screens/
└── main.dart