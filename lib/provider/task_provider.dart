import 'package:flutter/material.dart';

import '../helper/database_helper.dart';
import '../model/task.dart';
import '../service/notification_service.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    _tasks.add(task);
    DatabaseHelper.instance.insert(task);
    NotificationService.scheduleNotification(task);
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    DatabaseHelper.instance.delete(task.title);
    NotificationService.cancelNotification(task);
    notifyListeners();
  }

  void loadTasks() async {
    _tasks = await DatabaseHelper.instance.queryAllTasks();
    notifyListeners();
  }
}
