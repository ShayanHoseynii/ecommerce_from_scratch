# 🛒 E-Commerce From Scratch (Flutter + Firebase + Cubit)

<p align="center">
  <a href="https://flutter.dev"><img alt="Flutter" src="https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white"></a>
  <a href="https://firebase.google.com"><img alt="Firebase" src="https://img.shields.io/badge/Firebase-Auth%20%7C%20Firestore%20%7C%20Storage-FFCA28?logo=firebase&logoColor=black"></a>
<img alt="Platforms" src="https://img.shields.io/badge/Platforms-Android%20%7C%20iOS-success">
</p>

<p align="center">
  A cross-platform shopping app built with <b>Flutter</b> and <b>Firebase</b> — modern UI, clean architecture, and scalable cloud services.
</p>


---

## ✨ Highlights

- 🔐 Auth: Email/Password + Google Sign-In
- 🛍️ Catalog: categories, brands, attributes, variations
- 🛒 Cart + coupons + checkout flow
- 📦 Addresses, order history, and profile settings
- ⭐ Featured brands + “You might like” recommendations
- ☁️ Cloud Functions to keep brand product counts in sync
- 💾 Offline-friendly storage + adaptive theming
- 🔔 FCM-ready notifications + analytics/crash hooks

---


### Target Audience & Value Proposition
- Shoppers who want a fast, elegant mobile shopping experience
- Small/medium retailers seeking an extensible reference app
- Developers learning Flutter + Firebase with clean architecture and BLoC

---


<h2 align="center">📱 App Screens</h2>

<p align="center">
  <img src="https://github.com/user-attachments/assets/461525be-c90a-4f68-9914-c4100f25b961" width="230" />
  &nbsp;&nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/3a6e9ce3-d6ec-46ed-aa0a-c9dbad543155" width="230" />
  &nbsp;&nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/3d68dd06-9a31-4503-a3c4-8d68e4b7690e" width="230" />
</p>

---



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

