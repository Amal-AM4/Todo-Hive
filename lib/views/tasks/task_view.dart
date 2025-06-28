import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:todo/extensions/space_exs.dart';
import 'package:todo/main.dart';
import 'package:todo/models/task.dart';
import 'package:todo/utils/app_colors.dart';
import 'package:todo/utils/app_str.dart';
import 'package:todo/utils/constants.dart';
import 'package:todo/views/tasks/components/date_time_selection.dart';
import 'package:todo/views/tasks/components/rep_textfield.dart';
import 'package:todo/views/tasks/widgets/task_view_app.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class TaskView extends StatefulWidget {
  const TaskView({
    super.key,
    this.titleTaskController,
    this.descriptionTaskController,
    this.task,
  });

  final TextEditingController? titleTaskController;
  final TextEditingController? descriptionTaskController;
  final Task? task;

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  var title;
  var subTitle;
  DateTime? time;
  DateTime? date;

  // if any task already exist return True otherwise false
  bool isTaskAlreadyExist() {
    return widget.task != null;
  }

  // Main function for creating or updating tasks
  // Main function for creating or updating tasks
  void isTaskAlreadyExistUpdateOtherWiseCreate() {
    final inputTitle = _titleController.text.trim();
    final inputSubTitle = _descriptionController.text.trim();

    // Validate fields
    if (inputTitle.isEmpty ||
        inputSubTitle.isEmpty ||
        time == null ||
        date == null) {
      emptyWarning(context); // show alert if anything is missing
      return;
    }

    if (isTaskAlreadyExist()) {
      // UPDATE existing task
      widget.task!.title = inputTitle;
      widget.task!.subTitle = inputSubTitle;
      widget.task!.createdAtTime = time!;
      widget.task!.createdAtDate = date!;
      widget.task!.save(); // Save changes to Hive
    } else {
      // CREATE new task
      final newTask = Task.create(
        title: inputTitle,
        subTitle: inputSubTitle,
        createdAtDate: date,
        createdAtTime: time,
      );
      BaseWidget.of(context).dataStore.addTask(task: newTask);
    }

    Navigator.pop(context); // ✅ optionally go back to previous screen
  }

  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = widget.titleTaskController ?? TextEditingController();
    _descriptionController =
        widget.descriptionTaskController ?? TextEditingController();
  }

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

              // Main Task View Activity
              _buildMainTaskViewActivity(textTheme, context),

              // Bottom side buttons
              _buildBottomSideButtons(),
            ],
          ),
        ),
      ),
    );
  }

  // Bottom side buttons
  Widget _buildBottomSideButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment:
            !isTaskAlreadyExist()
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceEvenly,
        children: [
          !isTaskAlreadyExist()
              ? Container()
              :
              // Delete current Task button
              MaterialButton(
                onPressed: () {},
                minWidth: 150,
                color: Colors.white,
                height: 55,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),

                child: Row(
                  children: [
                    Icon(Icons.close, color: AppColors.primaryColor),
                    5.w,
                    Text(
                      AppStr.deleteTask,
                      style: TextStyle(color: AppColors.primaryColor),
                    ),
                  ],
                ),
              ),

          // Add or Update Task
          MaterialButton(
            onPressed: () {
              isTaskAlreadyExistUpdateOtherWiseCreate();
            },
            minWidth: 150,
            color: AppColors.primaryColor,
            height: 55,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),

            child: Text(
              AppStr.addTaskString,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // Main Task View Activity
  SizedBox _buildMainTaskViewActivity(
    TextTheme textTheme,
    BuildContext context,
  ) {
    return SizedBox(
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
          RepTextField(
            controller: _titleController,
            onChanged: (String inputTitle) {
              title = inputTitle;
            },
            onFieldSubmitted: (String inputTitle) {
              title = inputTitle;
            },
          ),
          70.h,

          RepTextField(
            controller: _descriptionController,
            onChanged: (String inputsubTitle) {
              title = inputsubTitle;
            },
            onFieldSubmitted: (String inputsubTitle) {
              title = inputsubTitle;
            },
            isForDescription: true,
          ),
          20.h,

          // Time selection
          DateTimeSelectionWidget(
            time:
                time != null ? DateFormat('hh:mm a').format(time!) : '-- : --',
            onTap: () {
              DatePicker.showTimePicker(
                context,
                showTitleActions: true,

                // Real-time
                onChanged: (selectedTime) {
                  log("Changing: $selectedTime");
                },

                // Final value
                onConfirm: (selectedTime) {
                  setState(() {
                    time = selectedTime; // ✅ update your state variable
                  });
                },
                currentTime: DateTime.now(),
                locale: LocaleType.en,
              );
            },
            title: AppStr.timeString,
          ),

          24.h,

          // Date Selection
          DateTimeSelectionWidget(
            time: date != null ? DateFormat.yMMMEd().format(date!) : 'No Date',
            onTap: () {
              DatePicker.showDatePicker(
                context,
                showTitleActions: true,
                maxTime: DateTime(2030, 4, 5),
                minTime: DateTime.now(),

                onConfirm: (selectedDate) {
                  setState(() {
                    date = selectedDate;
                  });
                },

                currentTime: DateTime.now(),
              );
            },
            title: AppStr.dateString,
          ),
        ],
      ),
    );
  }

  // Top side texts
  Widget _buildTopSideTexts(TextTheme textTheme) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 70, child: Divider(thickness: 2)),

          // will decide to add or update
          RichText(
            text: TextSpan(
              text:
                  !isTaskAlreadyExist()
                      ? AppStr.addNewTask
                      : AppStr.updateCurrentTask,
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
