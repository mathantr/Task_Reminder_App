# taskremainderapp

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
# Task_Reminder_App


Detailed Explanation of Starting and Running a Flutter Project (Version 3.27)

Step 1: Open a Code Editor to Write and Compile the Code
Using VS Code:

Open VS Code and open the project folder by going to File > Open Folder, and select the folder of your Flutter project.

Using Android Studio:

Open Android Studio and select Open an existing project. Choose the folder where your Flutter project is stored.

Step 2: Select a Virtual Device (Simulator or Emulator)

To run your Flutter app, you need to test it on a virtual device. You can either use a Simulator (for iOS) or an Emulator (for Android). These devices simulate real devices on your computer, allowing you to test your app.

Selecting a Virtual Device for Android (Android Emulator)

If you're on macOS, you can use the iOS Simulator.
Open Xcode (Xcode is required for iOS development on Flutter).
Go to Xcode > Open Developer Tool > Simulator.
From here, you can select a device model, such as iPhone 16 , and the simulator will launch.
Running the Simulator:

Ensure the Simulator is running before you try to run your Flutter project on it.

Step 3: Open a Terminal in the Project Directory and Run flutter pub get
Once your code editor is open and your virtual device is running, you need to set up the project’s dependencies. This is where the flutter pub get  command comes into play.

Navigate to the Project Directory:

Run flutter pub get:


This command tells Flutter to fetch all the packages and dependencies defined in your pubspec.yaml file.

Step 4: Run the Flutter Project
After you have opened the project in the code editor, selected a virtual device, and installed dependencies using flutter pub get, you are ready to run your Flutter project.

Run the Project on the Selected Device:


Project Explanation


Step 1: Display Task List
The application will first display a list of tasks from the task list. This is the main screen where all the tasks are visible to the user.

Step 2: Add New Task
If the user wants to add a new task, a Floating Action Button (FAB) will appear at the bottom of the screen. By clicking the Add Icon on this button, the user will be navigated to the Add Task page.

Step 3: Add Task Details
On the Add Task page, the user will be prompted to enter the following task details:

Title: The name or title of the task.
Description: A description of the task.
Time: A specific time for the task, which can be selected using a time picker.
The user can fill in these fields and save the task.

Step 4: Task Notifications
Once the task is saved with a specific time, the app will notify the user at the chosen time. If the app is running in the foreground or closed, a notification will appear at the scheduled time to remind the user about the task.

Step 5: Store Data Locally
All task data will be stored in a local database (such as SQLite) to ensure data persistence. This allows the tasks to be available even after the app is closed and reopened.

Step 6: Delete Task from List
To delete a task, the user can swipe left on a list item in the task list. This will reveal a Delete button. If the user fully swipes the item to the left, the task will be deleted from the list and the local database.