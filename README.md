# 🧠 Path to Balance - An AI-Powered Mental Health Screening App

<p align="center">
<img src="https://github.com/user-attachments/assets/192bc0e3-bdbd-4bdb-935f-cffd19459d61" width="350">
</p>

Path to Balance is a cross-platform Flutter application designed to provide users with immediate, accessible mental health screening. The app uses structured questionnaires and a powerful AI backend to deliver personalized psychological evaluations, helping users understand their mental state and providing actionable suggestions for well-being.

This project was developed by a two-person team: the Flutter frontend was built by me, and the Node.js backend was built by my collaborator.

---

## ✨ Key Features

- ✅ **Secure Authentication** via Supabase for user data protection.
- ✅ **Dynamic Questionnaires** that adapt based on user status.
- ✅ **Real-Time AI Evaluation** of responses to generate detailed psychological reports.
- ✅ **Comprehensive Results** including sentiment, risk level, summary, and actionable advice.
- ✅ **Assessment History** allowing users to track their mental health journey over time.
- ✅ **Modern & Accessible UI** built with Flutter and a custom Material Design 3 theme.

## 🛠️ Tech Stack

| Category          | Tech                                          |
| ----------------- | --------------------------------------------- |
| **Framework**     | [Flutter](https://flutter.dev) (Dart)         |
| **State Mngmt**   | [Provider](https://pub.dev/packages/provider) |
| **Backend Auth**  | [Supabase](https://supabase.io)               |
| **API Backend**   | Custom Node.js REST API (separate repository) |
| **Networking**    | `http` package                                |
| **Local Storage** | Shared Preferences                            |

## 👨‍💻 Author

-   **Amey Pacharkar** – [LinkedIn](https://www.linkedin.com/in/amey-pacharkar-28520b307) | [GitHub](https://github.com/AmeyPacharkar1896)

---

<details>
<summary><b>View Technical Details & Setup Instructions</b></summary>
<br>

### 📁 Folder Structure

```bash
lib/
├── core/ # Environment, constants
├── modules/
│ ├── auth/ # Supabase login logic
│ ├── home/ # Dashboard + recent assessments
│ ├── questionnaire/ # Questionnaires & AI evaluation
│ ├── past_assessment_evaluation/ # History + result viewing
│ └── profile/ # (optional user profile)
├── routes/ # Navigation routes
└── main.dart
```

### 🛠️ Setup Instructions

#### Prerequisites

-   Flutter SDK >= 3.x
-   Dart >= 3.x
-   A configured Supabase Project with the required tables and RLS policies.
-   A running instance of the AI Backend API.

#### Steps

```bash
# 1. Clone the repository
git clone https://github.com/AmeyPacharkar1896/path_to_balance_frontend.git
cd path-to-balance-frontend

# 2. Install dependencies
flutter pub get

# 3. Configure your environment
#Add a .env file in the root folder of project
.env file
BASE_URL=YOUR_BACKEND_URL

# 4. Run the app
flutter run
```
</details>