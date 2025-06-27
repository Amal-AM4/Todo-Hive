import 'dart:developer';

// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import 'package:todo/extensions/space_exs.dart';
import 'package:todo/utils/app_str.dart';
import 'package:todo/views/tasks/components/rep_textfield.dart';
import 'package:todo/views/tasks/widgets/task_view_app.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart'
    as PluginDatetimePicker;

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  final TextEditingController titleTaskController = TextEditingController();
  final TextEditingController descriptionTaskController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        // AppBar
        appBar: TaskViewApp(),
        backgroundColor: Colors.white,

        // body
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              // Top side texts
              _buildTopSideTexts(textTheme),

              SizedBox(
                width: double.infinity,
                height: 530,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title of TextFiled
                    Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Text(
                        AppStr.titleOfTitleTextField,
                        style: textTheme.headlineMedium,
                      ),
                    ),

                    // Task Title
                    RepTextField(controller: titleTaskController),
                    70.h,

                    RepTextField(
                      controller: descriptionTaskController,
                      isForDescription: true,
                    ),
                    20.h,

                    GestureDetector(
                      onTap: () {
                        PluginDatetimePicker.DatePicker.showDatePicker(
                          context,
                          showTitleActions: true,
                          minTime: DateTime(2000),
                          maxTime: DateTime(2100),
                          onConfirm: (date) {
                            print("Selected date: $date");
                          },
                          currentTime: DateTime.now(),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        width: double.infinity,
                        height: 55,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                AppStr.timeString,
                                style: textTheme.headlineSmall,
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(right: 10),
                              width: 80,
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade200,
                              ),
                              child: Center(
                                // This text will show Date Time as Time
                                child: Text(
                                  "Time",
                                  style: textTheme.titleSmall,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopSideTexts(TextTheme textTheme) {
    return SizedBox(
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
    );
  }
}
