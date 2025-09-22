# Flutter Firebase Login Demo

This project is my assessment task submission.  
It demonstrates a simple **Flutter app** integrated with **Firebase Authentication** to handle user registration, login, and logout.

---

## Objective
- Build a Flutter app with Firebase Authentication.
- Provide a Login Page with **Full Name, Email, and Password**.
- Create a Home Page greeting the user by their full name and including a logout button.

---

## Project Structure
lib/
main.dart # App entry point, Firebase initialization, routing
firebase_options.dart # Auto-generated Firebase configuration
services/
auth_service.dart # Handles registration, login, logout logic
pages/
login_page.dart # Login/Register UI with input validation
home_page.dart # Home screen after login with greeting + logout

yaml
Copy code

---

## Features
- **Register**: Create new users with full name, email, and password.
- **Login**: Authenticate existing users with Firebase.
- **Firestore Integration**: Store full name in Firestore for each registered user.
- **Homepage**: Displays personalized greeting → `Hey, <Name>! You're successfully logged in.`
- **Logout**: Signs out the user and redirects back to the login page.
- **Validation**:
  - Full Name required for registration.
  - Email format validation.
  - Password must be at least 6 characters.

---

## Setup Instructions
1. Clone the repository:
   ```bash
   git clone https://github.com/DVv66/babylon-app.git
   cd babylon-app
Install dependencies:

bash
Copy code
flutter pub get
Run the app (Web example):

bash
Copy code
flutter run -d chrome --web-hostname 127.0.0.1 --web-port 5500
Firebase setup:

Firebase project already created and configured via flutterfire configure.

firebase_options.dart included for initialization.

Testing Scenarios
✅ New user registration → full name saved + greeting shown.

✅ Existing user login → redirected to Home Page.

✅ Logout → redirected back to Login Page.

Challenges
Setting up FlutterFire CLI and Firebase CLI on Windows required enabling Developer Mode for symlink support.

Authentication errors when pushing to GitHub were resolved by switching to PAT (Personal Access Token).

Managing input validation for both login and registration in a single form.

Possible Improvements
Add password reset via Firebase.

Add persistent login state across app restarts.

Improve UI/UX with Material 3 widgets.

Extend support for Android and iOS with full Firebase configuration.
