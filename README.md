# Kharis Investment Services App

A cross-platform Flutter application for a financial services company, built with Firebase and GetX.

## Features

### Client Side
- **Onboarding:** Smooth 3-slide introduction.
- **Authentication:** Sign up and Login.
- **Dashboard:** Summary of active loans and insurance policies.
- **Loan Management:** Apply for loans and track application status.
- **Policy Management:** View available policies and send inquiries.
- **Support:** In-app messaging for customer support.
- **Notifications:** Stay updated with policy and loan approvals.
- **Profile:** Manage personal information.

### Admin Side
- **Overview:** Dashboard with real-time stats (Total Clients, Pending Apps, etc.).
- **Client Management:** Searchable client list and detailed profiles.
- **Loan Approvals:** Approve or reject loan applications.
- **Policy Management:** Update and manage client policies.
- **Communications:** Send notifications to specific clients or all users.

## Tech Stack
- **Framework:** Flutter (Latest Stable)
- **State Management & Routing:** GetX
- **Backend:** Firebase (Auth, Firestore, Storage, Cloud Messaging)
- **Styling:** Google Fonts (Poppins), custom professional green theme.

## Setup Instructions

1. **Prerequisites:**
   - Flutter SDK installed.
   - Firebase project created.

2. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd kharis_investment_services
   ```

3. **Install dependencies:**
   ```bash
   flutter pub get
   ```

4. **Firebase Configuration:**
   - Replace the dummy values in `lib/firebase_options.dart` with your actual Firebase project configuration.
   - For Android: Place `google-services.json` in `android/app/`.
   - For iOS: Place `GoogleService-Info.plist` in `ios/Runner/`.

5. **Run the app:**
   ```bash
   flutter run
   ```

## Folder Structure
```
lib/
├── core/         # Constants, Theme, Utils
├── data/         # Models, Repositories, Services
├── features/     # Auth, Client, Admin, Notifications
├── shared/       # Widgets, Layouts
└── main.dart
```

## Security Rules
Make sure to deploy the provided `firestore.rules` and `storage.rules` to your Firebase project to ensure data privacy and role-based access.
