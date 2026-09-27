# Flutter Assignments & Mini Projects Hub

**Student Name:** Himanshu Raj  
**Degree/Course:** B.Tech (Computer Science & Engineering)  
**Repository:** [https://github.com/ErebAsh/FlutterAssignments](https://github.com/ErebAsh/FlutterAssignments)

---

## 📱 Project Overview

This repository hosts a unified, multi-week Flutter portfolio app built with Flutter Material 3, containing complete implementations for **Week 1** and **Week 2** coursework.

An interactive **Week 1 / Week 2 switcher** in the app header allows evaluators to seamlessly toggle between all assignments and mini-projects.

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
├── main.dart                      # App entry point, Week 1 & Week 2 switcher, theme toggle
│
├── week1/                         # Week 1 Solutions
│   └── screens/
│       ├── hello_flutter_screen.dart  # Assignment 1: "Hello Flutter" with Name & Course
│       ├── profile_card_screen.dart   # Assignment 2: Profile Card using Container, Row, Column, Image, Text
│       └── personal_info_screen.dart  # Mini Project: Responsive Personal Info App
│
└── week2/                         # Week 2 Solutions
    ├── todo/                      # Assignment 1: To-Do List App (2 Screens)
    │   ├── models/todo_task.dart
    │   └── screens/
    │       ├── todo_list_screen.dart  # Screen 1: Task list with filters & progress
    │       └── add_task_screen.dart   # Screen 2: Add task with TextField & setState
    │
    ├── auth_demo/                 # Assignment 2: Login Page + Home Page Navigation
    │   └── screens/
    │       ├── login_screen.dart      # Login with validation, obscure toggle, demo fill
    │       └── home_screen.dart       # Home dashboard, user session, logout dialog
    │
    └── expense_tracker/           # Mini Project: Expense Tracker UI App
        ├── models/expense_item.dart
        ├── state/expense_controller.dart # Local state management (ChangeNotifier)
        ├── screens/
        │   ├── dashboard_screen.dart      # Total balance, breakdown, recent transactions
        │   ├── add_expense_screen.dart    # Add transaction with categories & date picker
        │   └── expense_history_screen.dart # Filterable, searchable transaction history
        └── expense_tracker_shell.dart     # Multi-screen navigation shell
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
   - **Home Page:** Displays personalized greeting with user parameters passed via `MaterialPageRoute`, session overview cards, and an interactive confirmation modal on logout (`Navigator.pop`).

3. **Mini Project: Expense Tracker UI App**
   - **Multiple Screens:**
     - **Dashboard:** Visual balance card (Total Balance, Income $\uparrow$, Expense $\downarrow$), category spending breakdown progress bars, and recent transactions.
     - **Add Expense:** Income vs. Expense toggle, amount validator, 12+ categorized choice chips, and interactive Date Picker (`showDatePicker`).
     - **History:** Full transaction history with live search by title/category, type filter chips, sorting (Date/Amount), and swipe-to-delete.
   - **Local State Management:** Clean data handling using Flutter's built-in `ChangeNotifier` (`ExpenseController`) without external heavy dependencies.
