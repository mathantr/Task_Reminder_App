import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/task.dart';
import '../provider/task_provider.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _title;
  String? _description;
  DateTime? _reminderTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value;
                },
              ),
              SizedBox(height: 20),
              Text(
                _reminderTime != null
                    ? 'Selected Date & Time: ${_reminderTime.toString()}'
                    : 'No Date & Time Selected',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickDateTime,
                child: Text('Select Reminder Time'),
              ),
              ElevatedButton(
                onPressed: _saveTask,
                child: Text('Save Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pickDateTime() async {
    if (Platform.isIOS) {
      await _showCupertinoDatePicker(context);
    } else {
      await _showMaterialDatePicker(context);
    }

    if (_reminderTime != null) {
      if (Platform.isIOS) {
        await _showCupertinoTimePicker(context);
      } else {
        await _showMaterialTimePicker(context);
      }
    }

    if (_reminderTime != null) {
      setState(() {
        _reminderTime = DateTime(
          _reminderTime!.year,
          _reminderTime!.month,
          _reminderTime!.day,
          _reminderTime!.hour,
          _reminderTime!.minute,
        );
      });
    }
  }

  Future<void> _showCupertinoDatePicker(BuildContext context) async {
    await showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height: 180,
                child: CupertinoDatePicker(
                  initialDateTime: DateTime.now(),
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (DateTime dateTime) {
                    setState(() {
                      _reminderTime = dateTime;
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showCupertinoTimePicker(BuildContext context) async {
    await showCupertinoModalPopup<TimeOfDay>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height: 180,
                child: CupertinoDatePicker(
                  initialDateTime: DateTime.now(),
                  mode: CupertinoDatePickerMode.time,
                  onDateTimeChanged: (DateTime dateTime) {
                    setState(() {
                      _reminderTime = DateTime(
                        _reminderTime!.year,
                        _reminderTime!.month,
                        _reminderTime!.day,
                        dateTime.hour,
                        dateTime.minute,
                      );
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showMaterialDatePicker(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _reminderTime = pickedDate;
      });
    }
  }

  Future<void> _showMaterialTimePicker(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _reminderTime = DateTime(
          _reminderTime!.year,
          _reminderTime!.month,
          _reminderTime!.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      });
    }
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final task = Task(
        title: _title!,
        description: _description!,
        reminderTime: _reminderTime!,
      );
      Provider.of<TaskProvider>(context, listen: false).addTask(task);
      Navigator.pop(context);
    }
  }
}
