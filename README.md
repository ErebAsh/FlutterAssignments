# Flutter Assignments & Capstone Project Hub

**Student Name:** Himanshu Raj  
**Degree/Course:** B.Tech (Computer Science & Engineering)  
**Repository:** [https://github.com/ErebAsh/FlutterAssignments](https://github.com/ErebAsh/FlutterAssignments)

---

## 📱 Project Overview

This repository hosts a production-grade, multi-week Flutter portfolio app built with Material 3, containing complete implementations for **Week 1**, **Week 2**, **Week 3**, and the **Week 4 Capstone Project**.

An interactive **W1 / W2 / W3 / W4 switcher** in the app header allows evaluators to seamlessly toggle between all assignments, mini-projects, and the capstone store.

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

### Android Device / Emulator:
```bash
flutter run
```

---

## 📦 APK Generation & Deployment (Week 4 Focus)

To generate release-ready Android application binaries:

### 1. Build Split APKs (Optimized size per CPU architecture):
```bash
flutter build apk --split-per-abi
```

### 2. Build Universal Release APK:
```bash
flutter build apk --release
```
*Output path:* `build/app/outputs/flutter-apk/app-release.apk`

### 3. Build Google Play Store App Bundle (AAB):
```bash
flutter build appbundle --release
```
*Output path:* `build/app/outputs/bundle/release/app-release.aab`

---

## 📂 Project Architecture

```
lib/
├── main.dart                      # App entry point, 4-week switcher, global theme toggle
│
├── week1/                         # Week 1: Basics & Layouts
│   └── screens/
│       ├── hello_flutter_screen.dart  # Assignment 1: "Hello Flutter" with Name & Course
│       ├── profile_card_screen.dart   # Assignment 2: Profile Card using 5 Core Widgets
│       └── personal_info_screen.dart  # Mini Project: Responsive Personal Info App
│
├── week2/                         # Week 2: State & Navigation
│   ├── todo/                      # Assignment 1: To-Do List App (2 Screens)
│   │   ├── models/todo_task.dart
│   │   └── screens/
│   │       ├── todo_list_screen.dart  # Screen 1: Task list with filters & progress
│   │       └── add_task_screen.dart   # Screen 2: Add task with TextField & setState
│   ├── auth_demo/                 # Assignment 2: Login Page + Home Page Navigation
│   │   └── screens/
│   │       ├── login_screen.dart      # Login with validation, obscure toggle, demo fill
│   │       └── home_screen.dart       # Home dashboard, user session, logout modal
│   └── expense_tracker/           # Mini Project: Expense Tracker UI App
│       ├── models/expense_item.dart
│       ├── state/expense_controller.dart # Local state management (ChangeNotifier)
│       ├── screens/
│       │   ├── dashboard_screen.dart      # Total balance, breakdown, recent transactions
│       │   ├── add_expense_screen.dart    # Add transaction with categories & date picker
│       │   └── expense_history_screen.dart # Filterable, searchable transaction history
│       └── expense_tracker_shell.dart     # Multi-screen navigation shell
│
├── week3/                         # Week 3: Networking & Cloud Backend
│   ├── public_api_news/           # Assignment 1: Fetch & display Public API data
│   │   ├── models/news_article.dart
│   │   ├── services/news_api_service.dart # Hacker News Firebase REST API
│   │   └── screens/public_news_screen.dart # Live feed, search, category chips, refresh
│   ├── firebase_auth/             # Assignment 2: Firebase Login Page
│   │   ├── models/firebase_auth_user.dart
│   │   ├── services/firebase_auth_service.dart # Email & password authentication service
│   │   └── screens/
│   │       ├── firebase_login_screen.dart   # Login/Signup, validation, forgot password
│   │       └── firebase_profile_screen.dart # Authenticated session & sign-out
│   └── weather_app/               # Mini Project: Weather Forecast App
│       ├── models/weather_data.dart
│       ├── services/weather_api_service.dart # OpenWeather API + live meteorological fallback
│       └── screens/weather_forecast_screen.dart # City search, temperature, humidity, 5-day forecast
│
└── week4/                         # Week 4: Capstone Project (Pulse E-Commerce App)
    ├── models/
    │   ├── product.dart           # Product specs, discount percentage, ratings, features
    │   ├── cart_item.dart         # Cart quantities, item totals
    │   └── order_model.dart       # Order status, delivery address, payment method
    ├── state/
    │   └── ecommerce_controller.dart # Master state: catalog, cart, wishlist, orders
    ├── screens/
    │   ├── product_catalog_screen.dart   # Search, category pills, adaptive product grid
    │   ├── product_detail_screen.dart    # Hero image, full specs, Add to Cart, Buy Now
    │   ├── cart_screen.dart              # Items list, stepper, subtotal, delivery calculation
    │   ├── checkout_payment_screen.dart  # Address form, mock payments (UPI/Card/COD)
    │   ├── order_success_screen.dart     # Order confirmation receipt and actions
    │   ├── order_history_screen.dart     # Past orders list with live visual status tracker
    │   └── ecommerce_auth_screen.dart    # Customer profile & Firebase session info
    └── ecommerce_app_shell.dart          # Master shell with bottom navigation & live cart badges
```

---

## 📝 Complete Coursework Specifications

### 🌟 Week 1: Fundamentals
1. **Assignment 1: Hello Flutter App**
   - Displays greeting **"Hello Flutter!"**, student name, and course details.
   - Interactive button with reactive greeting counter.
2. **Assignment 2: Profile Card App**
   - Built strictly using 5 core widgets: `Container`, `Row`, `Column`, `Image`, and `Text`.
   - Verified with an on-screen widget checklist badge.
3. **Mini Project: Personal Info App**
   - Responsive multi-column layout adapting across mobile, tablet, and desktop.
   - Interactive skill badges and tap-to-copy contact information cards.

---

### 🌟 Week 2: State & Navigation
1. **Assignment 1: To-Do List App (2 Screens)**
   - **Screen 1 (List of Tasks):** Displays active/completed tasks, completion progress bar, filter segments (All, Active, Completed), checkbox toggles, and swipe-to-delete with undo action.
   - **Screen 2 (Add Task Screen):** Built using `TextField` controllers, form validation, category selection, and `setState`, returning the new task via `Navigator.pop(context, newTask)`.
2. **Assignment 2: Login Page + Home Page Navigation Demo**
   - **Login Page:** Clean card layout with email format validation, password visibility toggle, remember-me checkbox, and "Fill Demo Credentials" helper.
   - **Home Page:** Displays personalized greeting with user parameters passed via `MaterialPageRoute`, session overview cards, and an interactive confirmation modal on logout.
3. **Mini Project: Expense Tracker UI App**
   - **Multiple Screens:** Dashboard, Add Expense, and History.
   - **Local State Management:** Clean data handling using Flutter's built-in `ChangeNotifier` (`ExpenseController`).

---

### 🌟 Week 3: Networking & Firebase Auth
1. **Assignment 1: Fetch and display data from a Public API**
   - Connects live to the Hacker News Firebase Public REST API via HTTP (`http.get`).
   - Parses strongly-typed `NewsArticle` models with JSON deserialization.
   - Features category filtering, title/author search, pull-to-refresh, loading spinners, and retry button.
2. **Assignment 2: Firebase Login Page (Email & Password Authentication)**
   - Email & password authentication with dedicated service layer (`FirebaseAuthService`).
   - Sign In vs. Sign Up mode toggling, real-time validation, forgot password dialog, and profile screen.
3. **Mini Project: Weather Forecast App**
   - Connects to OpenWeather API (with API key dialog) + live global geocoding & meteorological fallback.
   - Displays temperature, humidity, wind, pressure, weather condition icons, and 5-day forecast.

---

### 🏆 Week 4: Capstone Project (Pulse E-Commerce App)
* **Production-Ready Mobile Application**:
  1. **Firebase Authentication & Profile:** Customer account management, session tracking, and saved address.
  2. **Product Catalog & Search:** Live keyword search, dynamic category filtering (*Audio, Wearables, Computing, Accessories*), promotional hero banners, discount badges, and rating stars.
  3. **Product Details:** Rich product images, specs list, quantity picker, wishlist toggle, and instant "Buy Now" flow.
  4. **Shopping Cart with Live Badge:** Real-time badge counter on the bottom navigation bar, quantity increment/decrement/removal, free delivery calculation, and order summary.
  5. **Mock Payment & Checkout:** Address input, payment gateway simulation (UPI / Cards / Net Banking / COD), and order processing.
  6. **Order Confirmation & Tracking:** Visual step-by-step delivery tracking timeline (*Placed $\rightarrow$ Confirmed $\rightarrow$ Out for Delivery $\rightarrow$ Delivered*).
