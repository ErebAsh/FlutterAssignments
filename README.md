# Flutter Assignments & Mini Projects Hub

**Student Name:** Himanshu Raj  
**Degree/Course:** B.Tech (Computer Science & Engineering)  
**Repository:** [https://github.com/ErebAsh/FlutterAssignments](https://github.com/ErebAsh/FlutterAssignments)

---

## 📱 Project Overview

This repository hosts a unified, multi-week Flutter portfolio app built with Flutter Material 3, containing complete implementations for **Week 1**, **Week 2**, and **Week 3** coursework.

An interactive **Week 1 / Week 2 / Week 3 switcher** in the app bar allows evaluators to toggle seamlessly between all weekly assignments and mini-projects in one click.

---

## 🚀 How to Run the App

You can run this project on any supported Flutter platform:

### Web (Chrome / Edge):
```bash
flutter run -d chrome
```

### Windows Desktop:
```bash
flutter run -d windows
```

### Android Emulator / Device:
```bash
flutter run
```

---

## 📂 Project Architecture

```
lib/
├── main.dart                      # App entry point, W1/W2/W3 segmented switcher, theme toggle
│
├── week1/                         # Week 1 Solutions
│   └── screens/
│       ├── hello_flutter_screen.dart  # Assignment 1: "Hello Flutter" with Name & Course
│       ├── profile_card_screen.dart   # Assignment 2: Profile Card using Container, Row, Column, Image, Text
│       └── personal_info_screen.dart  # Mini Project: Responsive Personal Info App
│
├── week2/                         # Week 2 Solutions
│   ├── todo/                      # Assignment 1: To-Do List App (2 Screens)
│   │   ├── models/todo_task.dart
│   │   └── screens/
│   │       ├── todo_list_screen.dart  # Screen 1: Task list with filters & progress
│   │       └── add_task_screen.dart   # Screen 2: Add task with TextField & setState
│   │
│   ├── auth_demo/                 # Assignment 2: Login Page + Home Page Navigation
│   │   └── screens/
│   │       ├── login_screen.dart      # Login with validation, obscure toggle, demo fill
│   │       └── home_screen.dart       # Home dashboard, user session, logout dialog
│   │
│   └── expense_tracker/           # Mini Project: Expense Tracker UI App
│       ├── models/expense_item.dart
│       ├── state/expense_controller.dart # Local state management (ChangeNotifier)
│       ├── screens/
│       │   ├── dashboard_screen.dart      # Total balance, breakdown, recent transactions
│       │   ├── add_expense_screen.dart    # Add transaction with categories & date picker
│       │   └── expense_history_screen.dart # Filterable, searchable transaction history
│       └── expense_tracker_shell.dart     # Multi-screen navigation shell
│
└── week3/                         # Week 3 Solutions
    ├── public_api_news/           # Assignment 1: Fetch & display Public API data
    │   ├── models/news_article.dart
    │   ├── services/news_api_service.dart # Hacker News Firebase REST API
    │   └── screens/public_news_screen.dart # Live feed, search, category chips, refresh
    │
    ├── firebase_auth/             # Assignment 2: Firebase Login Page
    │   ├── models/firebase_auth_user.dart
    │   ├── services/firebase_auth_service.dart # Email & password authentication service
    │   └── screens/
    │       ├── firebase_login_screen.dart   # Login/Signup, validation, forgot password
    │       └── firebase_profile_screen.dart # Authenticated session & sign-out
    │
    └── weather_app/               # Mini Project: Weather Forecast App
        ├── models/weather_data.dart
        ├── services/weather_api_service.dart # OpenWeather API + live meteorological fallback
        └── screens/weather_forecast_screen.dart # City search, temperature, humidity, 5-day forecast
```

---

## 📝 Assignment Specifications

### 🌟 Week 1
1. **Assignment 1: Hello Flutter App**
   - Displays greeting **"Hello Flutter!"**, student name, and course details.
   - Interactive button with reactive snackbar counter.
2. **Assignment 2: Profile Card App**
   - Explicitly built using 5 core widgets: `Container`, `Row`, `Column`, `Image`, and `Text`.
   - Verified with an on-screen widget checklist badge.
3. **Mini Project: Personal Info App**
   - Responsive multi-column layout adapting across mobile, tablet, and desktop.
   - Interactive skill badges and tap-to-copy contact information cards.

---

### 🌟 Week 2
1. **Assignment 1: To-Do List App (2 Screens)**
   - **Screen 1 (List of Tasks):** Displays active/completed tasks, completion progress bar, filter segments (All, Active, Completed), checkbox toggles, and swipe-to-delete with undo action.
   - **Screen 2 (Add Task Screen):** Built using `TextField` controllers, form validation, category selection, and `setState`, returning the new task via `Navigator.pop(context, newTask)`.
2. **Assignment 2: Login Page + Home Page Navigation Demo**
   - **Login Page:** Clean card layout with email format validation, password visibility toggle, remember-me checkbox, and "Fill Demo Credentials" helper.
   - **Home Page:** Displays personalized greeting with user parameters passed via `MaterialPageRoute`, session overview cards, and an interactive confirmation modal on logout.
3. **Mini Project: Expense Tracker UI App**
   - **Multiple Screens:** Dashboard (visual balance card, income/expense breakdown, recent transactions), Add Expense (income/expense toggle, amount validator, 12+ categories, date picker), History (search, filter, sort, swipe-to-delete).
   - **Local State Management:** Clean data handling using Flutter's built-in `ChangeNotifier` (`ExpenseController`).

---

### 🌟 Week 3
1. **Assignment 1: Fetch and display data from a Public API**
   - Connects live to the Hacker News Firebase Public REST API via HTTP (`http.get`).
   - Parses strongly-typed `NewsArticle` models with JSON deserialization.
   - Features category filtering (Tech, Mobile, AI, Security, Design), title/author search, pull-to-refresh (`RefreshIndicator`), loading spinners, and error handling with a retry button.
2. **Assignment 2: Firebase Login Page (Email & Password Authentication)**
   - Implements email & password authentication workflows with a dedicated service layer (`FirebaseAuthService`).
   - Features Sign In vs. Sign Up mode toggling, real-time email regex validation, password length & security requirements, and show/hide visibility toggle.
   - Includes "Forgot Password?" dialog with password reset email dispatch.
   - "Fill Demo Credentials" button for instant testing and a dedicated profile screen with session details upon successful authentication.
3. **Mini Project: Weather Forecast App**
   - Connects to OpenWeather API (with an on-screen API key configuration dialog) and includes an automatic live global geocoding + meteorological fallback so any city works out of the box with zero setup.
   - Displays real-time temperature (°C), feels-like temp, humidity (%), wind speed (km/h), and atmospheric pressure (hPa).
   - Displays dynamic weather condition icons for clear, cloudy, rainy, thunderstorm, snow, and fog conditions.
   - Provides an interactive 5-day weather forecast horizontal card strip.
   - Full loading indicators (`CircularProgressIndicator`) and comprehensive error handling for non-existent cities and network disruptions with retry actions.
