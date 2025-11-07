# E‑Commerce From Scratch

[![Build](https://img.shields.io/badge/CI-passing-brightgreen.svg)](#)
[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](#)
[![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart->=3.7-blue?logo=dart)](https://dart.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Auth%20%7C%20Firestore%20%7C%20Storage-FFCA28?logo=firebase&labelColor=000)](https://firebase.google.com)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](#license)


## Project Description

E‑Commerce From Scratch is a cross‑platform shopping application built with Flutter and Firebase. It delivers a smooth shopping experience across Android, iOS, Web, macOS, Windows, and Linux, featuring modern UI, robust state management, and scalable cloud services.

### Key Features
- Authentication with Email/Password and Google Sign‑In
- Product catalog with categories, brands, variations, and attributes
- Cart management, coupon entry, and checkout flow
- User addresses, orders history, and profile settings
- Featured brands and “You might like” recommendations
- Firebase Cloud Functions to keep brand product counts in sync
- Offline storage and device‑friendly themes
- Push notifications (FCM ready), crash logging, and analytics hooks

### Target Audience & Value Proposition
- Shoppers who want a fast, elegant mobile shopping experience
- Small/medium retailers seeking an extensible reference app
- Developers learning Flutter + Firebase with clean architecture and BLoC

### Screenshots
> Place the following images at `docs/screenshots/` to render them in GitHub.

| Home | Cart (Empty) | Profile |
|---|---|---|
| ![Home screen UI showing categories, banner, and products](docs/screenshots/home.png) | ![Empty cart screen with CTA to start shopping](docs/screenshots/cart-empty.png) | ![Profile and account settings screen with logout](docs/screenshots/profile.png) |


## Installation

### System Requirements
- Flutter 3.x and Dart >= 3.7
- Android Studio (API 21+) and/or Xcode (iOS 13+)
- Node.js 18+ and Firebase CLI (for Cloud Functions and emulators)
- A Firebase project with Authentication, Firestore, Storage, and Messaging enabled

### Step‑by‑Step Setup
1. Install Flutter and verify:
   ```bash
   flutter --version
   flutter doctor
   ```
2. Clone the repository and fetch dependencies:
   ```bash
   git clone <your-repo-url>
   cd ecommerce_from_scratch
   flutter pub get
   ```
3. Configure Firebase (generates `lib/firebase_options.dart`):
   ```bash
   firebase login
   dart pub global activate flutterfire_cli
   flutterfire configure
   ```
   This writes platform configs and updates `DefaultFirebaseOptions.currentPlatform` used in `main.dart`.
4. Add platform credentials:
   - Android: place `android/app/google-services.json`
   - iOS: place `ios/Runner/GoogleService-Info.plist`
5. Initialize Cloud Functions (optional):
   ```bash
   cd functions
   npm install
   # Local emulation
   firebase emulators:start --only functions,firestore
   # or deploy
   firebase deploy --only functions
   ```
6. (Optional) Configure push notifications with FCM for Android/iOS.

### Environment Variables Configuration
This app uses FlutterFire’s generated `DefaultFirebaseOptions` instead of a `.env` file. Ensure:
- `lib/firebase_options.dart` exists and contains your Firebase project keys.
- Android `google-services.json` and iOS `GoogleService-Info.plist` are present.

### Database Setup
Enable Cloud Firestore and create the following collections:
- `Products` – product documents with fields like `title`, `price`, `images`, `categoryIds`, `brand` (embedded), `productAttributes`, `productVariations`.
- `Brands` – brand documents, including `name`, `image`, `productCount`.
- `Categories` – category documents with `Name`, `Image`, `ParentId`, `IsFeatured`.
- `Users/{uid}/Addresses` – user address sub‑collection.
- `Users/{uid}/Orders` – user orders sub‑collection.

Example product document:
```json
{
  "title": "Polot Tshirt",
  "price": 10.0,
  "salePrice": 12.0,
  "thumbnail": "https://...",
  "categoryIds": ["clothing"],
  "brand": {"id": "nike", "name": "Nike", "image": "https://..."},
  "images": ["https://.../1.png", "https://.../2.png"],
  "productAttributes": [{"name": "Size", "values": ["S","M","L"]}],
  "productVariations": [{"id": "sku-1", "price": 10.0, "stock": 25}]
}
```


## Usage

### Run the Application
```bash
flutter run
```
Targets Android, iOS, web, and desktop depending on your configured toolchains.

### Typical User Flow
- Onboarding → Login/Signup (Email/Password or Google)
- Browse store (categories, featured brands, recommendations)
- View product details → add to cart → checkout
- Manage addresses and review order history under Profile

### Admin/Back‑Office
- Use Firebase Console or a CMS to manage Products, Brands, and Categories.
- Cloud Functions automatically update `Brands.productCount` when products are created/deleted.


## Technology Stack

### Frontend
- Flutter 3.x
- State management: BLoC (`flutter_bloc`) and GetX (routing, storage)
- UI libraries: `google_fonts`, `iconsax`, `carousel_slider`, `lottie`, `readmore`, `badges`, `shimmer`

### Backend & Services
- Firebase Authentication (Email/Password, Google Sign‑In)
- Cloud Firestore (catalog, orders, addresses)
- Firebase Storage (media assets)
- Firebase Cloud Functions (brand product count sync)
- Firebase Messaging (notifications ready), Crashlytics

### Database Systems
- Cloud Firestore (document store)
- Firebase Storage (binary media)

### Third‑Party APIs/Services
- Google Sign‑In
- Optional: Supabase SDK present but not actively used in the app flow


## Configuration

### Environment Reference
- `lib/firebase_options.dart` – auto‑generated via `flutterfire configure`
- `android/app/google-services.json` – Android Firebase config
- `ios/Runner/GoogleService-Info.plist` – iOS Firebase config

### Important Settings
- Update app name/bundle identifiers in platform projects
- Theme: edit `lib/utils/theme/` to customize light/dark colors and typography
- Assets: declare under `pubspec.yaml` and place in `assets/`

### Customization Options
- Replace icons and brand imagery in `assets/`
- Extend product attributes/variations in models and UI
- Add payment gateways (Stripe/PayPal) in the checkout flow


## API Documentation

### Cloud Functions (Firestore Triggers)
- `onProductCreated (Products/{productId})` → increments `Brands.productCount`
- `onProductDeleted (Products/{productId})` → decrements `Brands.productCount`

Example event data (simplified):
```json
{
  "brand": { "id": "nike" },
  "title": "Sneaker",
  "price": 65.0
}
```

### Firestore Access Patterns (App)
- Products: `Products` and queries by `categoryIds` or document IDs
- Brands: `Brands` collection
- Categories: `Categories` collection
- Orders: `Users/{uid}/Orders`
- Addresses: `Users/{uid}/Addresses`

### Authentication Methods
- Email/Password: register, login, password reset, email verification
- Google Sign‑In: OAuth flow via `google_sign_in`


## Contributing

### Guidelines
- Fork the repo and create feature branches
- Write clear commit messages and PR descriptions
- Include screenshots for UI changes

### Code Style
- Run `flutter analyze` and fix warnings
- Format with `dart format .`
- Follow BLoC patterns for state and keep UI widgets lean

### Pull Request Process
1. Update documentation for any behavior changes
2. Add/adjust tests if applicable
3. Ensure CI passes
4. Request review and respond to feedback


## License

This project is licensed under the MIT License. You may use, modify, and distribute the software with attribution. See the LICENSE file if provided; otherwise, treat this section as the current licensing statement.


## Contact Information

- Maintainer: Your Name
- Email: your.email@example.com
- Support: Open a GitHub Issue with steps to reproduce
- Security: Report vulnerabilities privately to the maintainer email
