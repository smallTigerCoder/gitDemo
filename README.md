# GitHub User Browser App

This iOS app is developed as part of a technical assessment for a technical interview project, a leading Japanese fintech company.

It allows users to search GitHub users, view user details and repositories, and browse repository pages. The app is structured using a scalable **MVVM + Router** architecture, with modular folders and clean separation of concerns.

---
Feature/
│
├── Model        // Data models
├── ViewModel    // Logic and state management
├── View         // UI Components and ViewControllers
└── Router       // Handles screen navigation

## 🧱 Architecture Overview

### 🔹 MVVM + Router

The project follows the **MVVM (Model-View-ViewModel)** pattern and utilizes a **Router** to decouple navigation logic. Each feature (UserList, UserDetail) is structured into the following layers:
---

## 📁 Project Structure

| Folder                | Description |
|-----------------------|-------------|
| **Extensions**        | Common UIKit enhancements (e.g. `UIImageView + Kingfisher`, `AlertManager`) |
| **GitDemo-clean**     | (Optional) Reserved for refactored modules |
| **GitDemo-mirror**    | (Optional) Backup or mirrored components |
| **Network**           | Networking layer with `APIRequest`, `NetworkManager`, and modular endpoint definitions |
| └── Core              | Base request handler and manager |
| └── EndPoints         | API endpoint logic per request (user list, user detail, repos) |
| **UserList**          | Displays a paginated list of GitHub users |
| └── Model             | `UserModel.swift` representing GitHub user |
| └── View              | Custom `UserCell` |
| └── Router            | Handles navigation from list to detail |
| **UserDetail**        | Displays detailed user info and non-forked repos |
| └── Model             | `UserDetailModel`, `UserRepoModel` |
| └── ViewModel         | `UserDetailViewModel.swift` for UI logic |
| └── View              | Custom UI components: `UserDetailHeader`, `RepoDetailController`, etc. |
| └── Router            | Handles navigation to repo web page (WKWebView) |

---

## ⚙️ Tech Stack

| Component      | Technology     | Description |
|----------------|----------------|-------------|
| Language       | Swift           | Primary language |
| Architecture   | MVVM + Router   | For testability and separation of concerns |
| Networking     | Alamofire       | For async HTTP requests |
| UI Layout      | SnapKit         | Declarative constraint layout |
| Image Loading  | Kingfisher      | Efficient image caching and async loading |
| Refreshing     | MJRefresh       | Pull-to-refresh and infinite scroll |
| Web            | WKWebView       | In-app web content viewer |

---

## 🌟 App Features

### 👥 User List Page

- Displays a paginated list of GitHub users.
- Each cell includes:
  - Profile avatar
  - GitHub username
- Supports:
  - Pull-to-refresh (`MJRefresh`)
  - Infinite scrolling
- Navigation:
  - Tapping a user leads to their detail page via `UserListRouter`.

### 👤 User Detail Page

- Displays:
  - Avatar
  - Username
  - Full name
  - Followers & Following
- Below the profile:
  - Non-forked public repositories
  - Each repo shows:
    - Repo name
    - Language
    - Star count
    - Description
- Tapping a repo opens `RepoDetailController` with a **WKWebView**.

### 🌐 Web View

- `RepoDetailController` renders the GitHub page of the selected repository.
- Displays loading spinner until content is fully loaded.

---

## 🔐 GitHub API Token Handling

- API requests are authenticated using a personal access token stored securely in **`Info.plist`**.
- Token is **excluded from version control** for security.
- If token is missing:
  - App still runs using unauthenticated mode (subject to 60 req/hour rate limit).

---

## 🚦 Error Handling & UX

- All network failures are caught and display user-friendly alerts via `AlertManager`.
- Graceful fallback on UI errors.
- Visual consistency is maintained with a clean light mode interface.

---

## 🌙 UI / Appearance

- App is **locked to Light Mode** to simplify visual testing and avoid dark mode issues.
- Auto Layout handled entirely via **SnapKit**, ensuring consistent UI across devices.

---

## 🌏 Regional Testing Notes

- The app has been tested under **VPN** conditions from mainland China to ensure GitHub API accessibility.
- Token injection helps reduce latency and avoid 403 errors.

---

## 🧪 Testing

- The code is modular and easy to unit test (e.g., `UserDetailViewModel`, `APIRequest`).
- Due to time constraints, explicit XCTest units are **not included** in this version.

---

## 🙋 Developer Notes

- I am currently based in mainland China, where GitHub API access often requires VPN. The app was developed and tested under these conditions to simulate international usage.
- Japanese language:
  - I have studied JLPT N5-level Japanese, including basic grammar, vocabulary, and reading, though I have not obtained a certificate.
  - I'm willing to resume learning if given the opportunity.
- English proficiency:
  - IELTS score: **6.0 overall**, **6.5 in speaking**
  - Comfortable in English communication and documentation.
- I appreciate your emphasis on both **engineering excellence** and **cultural fit**.

---

## 🔗 Submission Info

- **GitHub Repo**: [https://github.com/smallTigerCoder/gitDemo](https://github.com/smallTigerCoder/gitDemo)
- **GitHub Token**: Injected via `Info.plist`, not hardcoded or committed.

Thank you for reviewing this submission! I am excited about the opportunity to join you and contribute to its mission with my iOS expertise and product mindset.
