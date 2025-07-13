# 📝 Blog App

A modern blog application built with Flutter, powered by Supabase for a robust backend, and designed for a smooth user experience.

---

## ✨ Features

* **User Authentication:** Secure sign-up and sign-in processes (Email & Password).
* **Blog Creation:** Authenticated users can create and publish their own blog posts.
* **Blog Viewing:** Browse and read blog posts with detailed views.
* **Image Handling:** Displays images associated with blog posts, including loading and error placeholders for a better user experience.
* **Reading Time Calculation:** Automatically estimates the reading time for articles.
* **Date Formatting:** Presents blog post dates in a user-friendly format.
* **Responsive UI:** Designed to adapt layouts smoothly across various screen sizes.
* **Dark Mode Support:** Adapts to system theme preferences, ensuring a comfortable viewing experience in low light.
* **Local Data Storage (Hive):** Leverages Hive for efficient local data persistence, potentially enabling offline capabilities or caching.

---

## 🚀 Technologies Used

* **Flutter:** The UI toolkit for building natively compiled applications from a single codebase.
* **Supabase:**
    * **Authentication:** Manages user registration and login.
    * **PostgreSQL Database:** Stores all application data, including blog posts and user profiles.
    * **Row Level Security (RLS):** Secures database access, ensuring data privacy and integrity.
    * **Storage:** Hosts images for blog posts.
* **Bloc:** A popular state management library for Flutter, facilitating predictable and testable application logic.
* **Hive:** A fast, lightweight, and local key-value database for efficient offline data management or caching.
* **Firebase (Potential):** While primarily Supabase-driven, the project structure suggests potential integration for services like analytics or crash reporting.
* **`path_provider`:** A Flutter plugin used to find common locations on the device file system, crucial for Hive initialization.

---

## 🛠️ Installation & Setup

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/yourusername/blog_app.git](https://github.com/yourusername/blog_app.git)
    cd blog_app
    ```

2.  **Install Flutter dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Supabase Setup:**
    * Create a new project on [Supabase](https://app.supabase.com/).
    * **Database:** Create a `blogs` table with essential columns (e.g., `id` (UUID, PK), `title`, `content`, `image_url`, `poster_id` (UUID, FK to `auth.users`), `topics` (text array), `updated_at` (timestamp)).
    * **Row Level Security (RLS):**
        * Enable RLS for the `blogs` table.
        * Add an **`INSERT` policy** (e.g., named "Allow authenticated user to create own blogs") with `Target roles: authenticated` and the `WITH CHECK` expression: `auth.uid() = poster_id`. This ensures users can only create their own posts.
    * **API Keys:** Obtain your project's `anon` (public) key and `URL` from your Supabase Project Settings > API.

4.  **Configure Supabase in Flutter:**
    * Open `lib/main.dart`.
    * Initialize Supabase with your project's URL and `anon` key.
    * **_Note_**: For production, consider using environment variables to manage sensitive keys securely.

5.  **Android Configuration:**
    * Navigate to `android/app/build.gradle`.
    * Set the `minSdkVersion` to `23` within the `defaultConfig` block to ensure compatibility with all dependencies, including `isar_flutter_libs`:
        ```gradle
        defaultConfig {
            // ...
            minSdk = 23
            // ...
        }
        ```

6.  **Run the application:**
    ```bash
    flutter run
    ```
    (Ensure an Android emulator or physical device is connected, or choose a web/desktop target.)

---

## 🎨 Styling & Theming Notes

* **`AppBar` / `CupertinoNavigationBar` Transparency:**
    * `AppBar` (Material): Background transparency is achieved via `AppBarTheme` in `ThemeData`.
    * `CupertinoNavigationBar`: Its `backgroundColor` is set directly on the widget instance, often conditionally based on `MediaQuery.of(context).platformBrightness` for dynamic dark mode support.
* **Cupertino Back Button:** To display the iOS-style caret back button across the app, ensure all route navigations utilize `CupertinoPageRoute`.
* **`cupertinoOverrideTheme`:** Used within `ThemeData` to apply global Cupertino styling (e.g., `brightness`, `primaryColor`, `textTheme`) to Cupertino widgets when they are embedded within a `MaterialApp` structure.

---

## 📂 Project Structure 
lib/
├── core/  
│   ├── common/  
│   ├── errors/  
│   ├── usecase/  
│   └── theme/  
│   └── secrets/  
├── features/  
│   ├── auth/  
│   │   ├── data/  
│   │   ├── domain/  
│   │   └── presentation/  
│   └── blog/  
│       ├── data/  
│       ├── domain/  
│       └── presentation/  
└── main.dart  



---

## 🤝 Contributing

Feel free to fork the repository, open issues, or submit pull requests. All contributions are welcome!

