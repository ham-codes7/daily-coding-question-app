# Daily Coding Question App

A Flutter + Firebase application that delivers one curated coding question per day to help students and beginners build consistent problem-solving habits.

This project was built as part of the GDSC technical task.

---

## Core Features

- Anonymous user authentication using Firebase Auth
- Exactly one global coding question per day for all users
- Users must submit an attempt before viewing the official solution
- Questions categorized by difficulty (Easy / Medium / Hard) and topic
- User streak tracking based on daily consistency
- Firestore-backed data persistence

---

## Tech Stack

- Flutter
- Firebase Authentication
- Firebase Firestore

---

## App Architecture

The app is structured using a clean separation of concerns:

### Models
- `CodingQuestion` – represents a daily coding problem
- `UserAttempt` – stores the user’s submitted answer
- `UserProgress` – tracks streaks and last attempt date

### Services
- `AuthService` – handles anonymous authentication
- `FirestoreService` – manages questions, attempts, and streak logic

### Screens
- `HomeScreen` – displays today’s question, accepts user input, and reveals the solution after submission

---

## Firestore Data Schema


