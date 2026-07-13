<div align="center">
  
  # 🛡️ CREW: Campus Reporting & Emergency Workflow
  
  **"Safe Voices. Stronger Campuses."**

  <p align="center">
    <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter" />
    <img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black" alt="Firebase" />
    <img src="https://img.shields.io/badge/Material%20Design%203-0081CB?style=for-the-badge&logo=material-design&logoColor=white" alt="Material Design 3" />
    <img src="https://img.shields.io/badge/UI%2FUX-Premium-8A2BE2?style=for-the-badge" alt="Premium UI/UX" />
  </p>

  <p align="center">
    A modern, secure, and highly confidential campus safety platform built to ensure every student can speak up without fear.
  </p>
</div>

---

## 📖 About The App

**CREW** is a high-trust campus safety platform designed to break the silence around university incidents. Built with **Flutter** and **Firebase**, it provides a secure, anonymous environment for students to report bullying, harassment, emergencies, and campus maintenance issues. 

Unlike traditional, clunky institutional portals, CREW is designed as a premium startup product. It utilizes frictionless onboarding, progressive disclosure for complex forms, and a carefully crafted color psychology to ensure students feel safe, calm, and protected while using it.

---

## 🎨 UI/UX & Design Philosophy

The application strictly adheres to **Google's Material Design 3 (MD3)**, focusing on visual hierarchy, accessibility, and trust.

* **Color Psychology:** A calming **Primary Blue** for the student experience, a distinct **Authoritative Green** for the Admin dashboard to separate environments, and an **Urgent Red** for emergency actions.
* **Visual Language:** Soft shadows, rounded Material cards, generous whitespace, and minimal, friendly illustrations.
* **Typography:** Clean, readable sans-serif typography ensuring accessibility during high-stress situations.

---

## 📱 Core Workflows & Screen Previews

<div align="center">
  <i>Note: Replace the placeholder image paths with the actual paths in your `/assets` folder when hosting on GitHub.</i>
</div>

### 1. Frictionless Authentication
The onboarding and authentication flow is designed to be welcoming and secure. 
* The **Login Screen** offers a clean interface with university email/registration inputs and social single sign-on (SSO) options.
* The **Create Account** screen features real-time password validation checkmarks to guide the user seamlessly through security requirements.

<table align="center">
  <tr>
    <td align="center"><img src="./assets/login.png" width="220" alt="Login"/></td>
    <td align="center"><img src="./assets/register.png" width="220" alt="Register"/></td>
    <td align="center"><img src="./assets/forgot.png" width="220" alt="Forgot Password"/></td>
  </tr>
  <tr>
    <td align="center"><b>Secure Login</b></td>
    <td align="center"><b>Guided Registration</b></td>
    <td align="center"><b>Password Recovery</b></td>
  </tr>
</table>

### 2. Student Dashboard & Emergency SOS
The student home screen prioritizes immediate action and visual clarity.
* A personalized greeting sits above a prominent, stark red **Emergency SOS** button, ensuring it is the highest item in the visual hierarchy.
* A horizontal scroll of quick-action icons (Report Incident, Campus Issues) allows for rapid navigation.

<table align="center">
  <tr>
    <td align="center"><img src="./assets/dashboard.png" width="250" alt="Dashboard"/></td>
    <td align="center"><img src="./assets/sos.png" width="250" alt="SOS Trigger"/></td>
  </tr>
  <tr>
    <td align="center"><b>Student Dashboard</b></td>
    <td align="center"><b>One-Tap Emergency SOS</b></td>
  </tr>
</table>

### 3. Progressive Incident Reporting
To reduce cognitive load on stressed users, the reporting process is broken down into a smooth, 5-step wizard:
1. **Category Selection:** Grid-based selection for issues like Bullying, Harassment, or Cyber Bullying.
2. **Details:** Time, date, and location inputs with a descriptive text area.
3. **Evidence Upload:** Secure media attachments.
4. **Privacy & Confidentiality:** A dedicated screen highlighting a secure toggle: *"Submit Anonymously - Your name will no be visible to anyone"*.
5. **Success State:** A reassuring confirmation screen.

### 4. The Admin Environment
The Admin app uses a distinct green UI theme to visually separate it from the student module.
* **Analytics Dashboard:** Displays high-level metrics like 'Total Complaints' via donut charts and recent activity feeds.
* **Complaint Management:** Admins can view evidence, update statuses (e.g., *Under Review*, *Resolved*), and securely notify the student without compromising their identity.

---

## 🛠️ Technical Architecture

The codebase is engineered for scalability, utilizing **Feature-First Architecture** and adhering to **SOLID principles**. 

### Tech Stack
* **Frontend:** Flutter, Material Design 3
* **State Management:** Riverpod
* **Routing:** GoRouter (with strict role-based guards)
* **Backend as a Service:** Firebase (Auth, Cloud Firestore, Storage)

### Folder Structure (Feature-First)
Every feature module (Auth, Dashboard, Reports, SOS) is highly cohesive and decoupled, containing its own:
`Models` ➔ `Repositories` ➔ `Services` ➔ `Controllers` ➔ `Screens` ➔ `Widgets`

---

## 🚀 Getting Started

To run this project locally, ensure you have the [Flutter SDK](https://docs.flutter.dev/get-started/install) installed.

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/maryamiee/crew.git](https://github.com/maryamiee/crew.git)
