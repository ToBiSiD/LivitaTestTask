# Livita Software - Test Task Solution

## Overview

This repository contains the solution for the Livita Software test task, which involves creating an iOS application to display a list of posts with comments. The application is built using Swift and leverages SwiftUI for the user interface.

## Features

### 1️⃣ Main Task

- **Home Screen:**
  - Displays a clickable list of posts.
  - Shows the name of the current user at the top (default user Id is 1).
  - Clicking on a post navigates to a new screen displaying the list of comments for that post.

### 2️⃣ Bonus Task

- **User Selection:**
  - Added a button in the top right corner of the main screen to open a list of users.
  - Selecting a user updates the posts list to show posts by the selected user.

### 3️⃣ Ninja Task

- **Data Caching:**
  - Integrated CoreData to cache posts, comments, and users for improved performance and offline support.

## Architecture

- **Framework:** SwiftUI
- **Architecture:** MVVM (Model-View-ViewModel)
- **Networking:** `URLSession` for network requests
- **Data Caching:** CoreData for local storage

## Screenshots

<div style="display: flex; justify-content: space-around;">
  <img src="https://github.com/user-attachments/assets/7a51d25d-3967-4232-b9be-004b96bad25a" alt="Home Screen" style="width: 30%;"/>
  <img src="https://github.com/user-attachments/assets/87f24afb-573e-4bf8-bb9c-bc6abaac2595" alt="Comments Screen" style="width: 30%;"/>
  <img src="https://github.com/user-attachments/assets/2213bbe6-0d5a-4a65-b926-6ead6190440c" alt="User Selection" style="width: 30%;"/>
</div>
