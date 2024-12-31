import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/task_provider.dart';
import 'screens/task_list_screen.dart';
import 'service/notification_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task Reminder App',
        home: TaskListScreen(),
      ),
    );
  }
}
