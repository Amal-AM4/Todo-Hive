import 'package:flutter/material.dart';
import 'package:todo/utils/app_str.dart';
import 'package:todo/views/tasks/widgets/task_view_app.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      // AppBar
      appBar: TaskViewApp(),
      backgroundColor: Colors.white,

      // body
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 70, child: Divider(thickness: 2)),
                  RichText(
                    text: TextSpan(
                      text: AppStr.addNewTask,
                      style: textTheme.titleLarge,
                      children: [
                        TextSpan(
                          text: AppStr.taskStrnig,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 70, child: Divider(thickness: 2)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
