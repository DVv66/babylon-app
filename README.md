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


Testing Scenarios
✅ New user registration → full name saved + greeting shown.

✅ Existing user login → redirected to Home Page.

✅ Logout → redirected back to Login Page.

## Challenges
Setting up FlutterFire CLI and Firebase CLI on Windows required enabling Developer Mode for symlink support.

Authentication errors when pushing to GitHub were resolved by switching to PAT (Personal Access Token).

Managing input validation for both login and registration in a single form.

## Possible Improvements
Add **password reset** (send password reset email).  

Persist login state across restarts with a splash/loading screen.  

Add **form error messages** with clearer UI feedback for invalid inputs. 

Add **loading indicators** during login/registration requests for better UX.  

## Images
<img width="929" height="917" alt="360截图20250922163721" src="https://github.com/user-attachments/assets/91d553f5-53c8-4073-a5c8-71757a4714fd" />
<img width="929" height="917" alt="360截图20250922163747" src="https://github.com/user-attachments/assets/4436d058-19d8-4736-96ea-ae18a7256597" />
<img width="1337" height="415" alt="360截图20250922172413" src="https://github.com/user-attachments/assets/94c1aaaf-d83c-4c70-b25d-ff8dca92b405" />
