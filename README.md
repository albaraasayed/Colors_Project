# Coloring Studio

## Overview
Coloring Studio is a beautifully designed Flutter application that allows users to generate, explore, and save custom color palettes. Powered by the Colormind API, it provides endless color combinations for designers, developers, and creatives.

## Key Features
- **Onboarding Experience:** A smooth welcome flow for first-time users featuring Lottie animations.
- **User Authentication:** Simple sign-in and session management.
- **Palette Generation:** Fetch dynamically generated color palettes via the Colormind API.
- **Color Details:** Tap on any color to view its Hex code and preview it dynamically.
- **Favorites Management:** Save your favorite colors locally and access them anytime on the dedicated Favorites screen.
- **Offline Storage:** Session states and favorite colors are persisted locally for a seamless experience.

## Tech Stack
- **Language:** Dart
- **Framework:** Flutter
- **State Management:** `flutter_bloc` (Cubit pattern)
- **Networking:** `dio`
- **External API:** [Colormind API](http://colormind.io/)
- **Local Storage:** `hive` / `hive_flutter` (for local database), `shared_preferences` (for session & onboarding flags)
- **Assets & Animations:** `flutter_svg`, `lottie`

## Architecture
The application follows a **Feature-first Architecture** combined with the **Cubit State Management Pattern** to ensure a clean separation of concerns and maintainability.
- **Features Directory (`lib/features`):** Contains modular feature folders (e.g., Auth, Favorites, Onboarding, Palette, Splash). Each feature folder encapsulates its own UI (`screens`) and business logic (`cubit`).
- **Core Directory (`lib/core`):** Houses shared functionalities such as networking (`DioHelper`), caching (`CacheHelper`, `HiveHelper`), and API constants.
- **Common Directory (`lib/common`):** Contains reusable UI tokens such as the app's color palette and text themes.

## Setup & Installation

Follow these steps to set up and run the project locally on your machine:

1. **Prerequisites:** Ensure you have the [Flutter SDK](https://flutter.dev/docs/get-started/install) installed (version ^3.11.3) and an emulator or physical device connected.
2. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd first_flutter
   ```
3. **Install dependencies:**
   ```bash
   flutter pub get
   ```
4. **Run the application:**
   ```bash
   flutter run
   ```
5. **Run tests (Optional):**
   ```bash
   flutter test
   ```