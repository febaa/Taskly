# Taskly

A sleek and modern Task Manager app built with Flutter, designed to help you organize your tasks efficiently. With a clean Material Design UI, support for light and dark themes, and robust state management, this app provides a professional to-do list experience. It uses the BLoC pattern for state management and Hive for local storage, ensuring a seamless and responsive user experience.

# Features

Add Tasks Easily: Create new tasks with a stylish dialog box.
Mark Tasks as Completed: Toggle task completion with a confirmation dialog and instant UI updates.
Delete Tasks: Remove tasks with a confirmation dialog to prevent accidental deletions.
Light & Dark Mode: Switch between vibrant light (teal/amber) and dark (teal/cyan) themes with a sun/moon toggle icon.
State Management with BLoC: Efficiently manage app state using the BLoC pattern for reactive updates.
Local Storage with Hive: Persist tasks locally using Hive, a lightweight NoSQL database.
Professional UI: Features a collapsible SliverAppBar, neumorphic task cards, Font Awesome icons, and Poppins typography.
Animations: Smooth slide-in effects for tasks, scale/fade for dialogs, and animated empty state.
Empty State: Displays a motivational message and icon when no tasks are present.

Screenshots

# Getting Started

Prerequisites
Flutter SDK: Version 3.0.0 or higher.
Dart: Version included with Flutter SDK.
A compatible IDE (e.g., VS Code, Android Studio) with Flutter plugins.
An emulator or physical device for testing.

Installation

Clone the Repository:
git clone https://github.com/febaa/task-manager-app.git
cd task-manager-app


Install Dependencies:Run the following command to fetch the required packages:
flutter pub get


Generate Hive Adapters:Generate the Hive adapter for the Task model:
flutter pub run build_runner build


Run the App:Connect an emulator or device and start the app:
flutter run



Dependencies
The app relies on the following packages:

flutter_bloc: For state management using the BLoC pattern.
hive: For local storage of tasks.
hive_flutter: Flutter integration for Hive.
path_provider: For accessing device storage paths.
equatable: For comparing state objects.
flutter_material_color_picker: For color selection (optional, not used in current UI).
flutter_animate: For smooth animations.
google_fonts: For Poppins typography.
font_awesome_flutter: For professional icons.

See pubspec.yaml for the complete list.
Project Structure
task-manager-app/
├── lib/
│   ├── bloc/
│   │   ├── task_bloc.dart
│   │   ├── task_event.dart
│   │   ├── task_state.dart
│   │   ├── theme_bloc.dart
│   │   ├── theme_event.dart
│   │   ├── theme_state.dart
│   ├── models/
│   │   ├── task.dart
│   ├── screens/
│   │   ├── home_screen.dart
│   ├── main.dart
├── pubspec.yaml
├── README.md

Usage

Adding a Task: Tap the Floating Action Button (FAB) with the + icon to open a dialog. Enter a task title and confirm to add it.
Completing a Task: Check the checkbox next to a task, confirm via the dialog, and see the task marked with a green checkmark and strikethrough.
Deleting a Task: Tap the trash icon, confirm via the dialog, and the task is removed.
Switching Themes: Tap the sun (light mode) or moon (dark mode) icon in the app bar to toggle themes.
Empty State: If no tasks exist, a centered icon and message encourage you to add tasks.

License
This project is licensed under the MIT License.

Contact
For questions or suggestions, open an issue or contact the maintainer at thomasfeba.07@gmail.com.

Built with 💙 using Flutter.
