import 'package:flutter/material.dart';
import 'package:todo/views/tasks/widgets/task_view_app.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(appBar: TaskViewApp());
  }
}
