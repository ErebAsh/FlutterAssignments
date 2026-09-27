# Flutter Assignments & Mini Project

**Student Name:** Himanshu Raj  
**Degree/Course:** B.Tech (Computer Science & Engineering)  

---

## 📱 Project Overview

This Flutter project contains solutions for all assigned tasks, unified with a modern Material 3 navigation bar and light/dark theme switcher:

1. **Assignment 1:** "Hello Flutter" App
2. **Assignment 2:** Profile Card App
3. **Mini Project:** Personal Info App

---

## 🚀 How to Run the App

You can run this app on Chrome, Edge, Windows, or an Android emulator/device:

### In Chrome (Web):
```bash
flutter run -d chrome
```

### In Windows Desktop:
```bash
flutter run -d windows
```

### In Edge Browser:
```bash
flutter run -d edge
```

---

## 📂 Project Structure

```
lib/
├── main.dart                      # App entry point, Material 3 theme & bottom navigation
└── screens/
    ├── hello_flutter_screen.dart  # Assignment 1: Hello Flutter with Name & Course
    ├── profile_card_screen.dart   # Assignment 2: Profile Card using Container, Row, Column, Image, Text
    └── personal_info_screen.dart  # Mini Project: Responsive Personal Info screen with skills & contact info
assets/
└── images/
    └── profile.jpg                # Profile photo asset for cards and avatar
```

---

## 📝 Assignment Details

### 1. Hello Flutter App (`lib/screens/hello_flutter_screen.dart`)
- Displays greeting: **"Hello Flutter!"**
- Displays **Student Name: Himanshu Raj**
- Displays **Course: B.Tech**
- Features interactive "Say Hello" button and snackbar greeting counter.

### 2. Profile Card App (`lib/screens/profile_card_screen.dart`)
Built strictly using the 5 core widgets:
- `Container`: Card framing, curved corners, drop shadows, and banner background.
- `Row`: Metrics display (Degree, Projects, Focus) and action buttons (Contact, Share).
- `Column`: Vertical alignment of banner, avatar, name, subtitle, and description.
- `Image`: Profile image (`Image.asset('assets/images/profile.jpg')` with fallback).
- `Text`: Name, designation, bio, and stat labels.

### 3. Mini Project: Personal Info App (`lib/screens/personal_info_screen.dart`)
- **Profile Photo:** High-resolution avatar with gradient ring and active status indicator.
- **Name & Headline:** "Himanshu Raj", "B.Tech • Student & Flutter Developer".
- **Skills:** Responsive wrap of colored skill badges (Flutter, Dart, C++, Python, Git, UI/UX, Responsive Layout, Problem Solving).
- **Contact Info:** Interactive contact cards for Email, Phone, GitHub, and LinkedIn with tap-to-copy functionality.
- **Responsive Layout:** Automatically adapts between multi-column (tablet/desktop) and single-column (mobile) formats.
