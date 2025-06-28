import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/models/task.dart';
import 'package:todo/utils/app_colors.dart';

class TaskWidget extends StatefulWidget {
  final Task task;

  const TaskWidget({super.key, required this.task});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  late TextEditingController titleController;
  late TextEditingController subTitleController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task.title);
    subTitleController = TextEditingController(text: widget.task.subTitle);
  }

  @override
  void dispose() {
    titleController.dispose();
    subTitleController.dispose();
    super.dispose();
  }

  void toggleCompletion() {
    setState(() {
      widget.task.isCompleted = !widget.task.isCompleted;
      widget.task.save();
    });
  }

  void saveChanges() {
    setState(() {
      widget.task.title = titleController.text;
      widget.task.subTitle = subTitleController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isCompleted = widget.task.isCompleted;

    return GestureDetector(
      onTap: () => _showEditDialog(context),
      child: AnimatedContainer(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color:
              isCompleted
                  ? const Color.fromARGB(30, 69, 104, 220)
                  : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(10, 0, 0, 0),
              offset: Offset(0, 4),
              blurRadius: 10,
            ),
          ],
        ),
        duration: const Duration(milliseconds: 600),
        child: ListTile(
          leading: GestureDetector(
            onTap: toggleCompletion,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: isCompleted ? AppColors.primaryColor : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey, width: .8),
              ),
              child:
                  isCompleted
                      ? const Icon(Icons.check, color: Colors.white, size: 18)
                      : null,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5, top: 3),
            child: Text(
              widget.task.title,
              style: TextStyle(
                color: isCompleted ? AppColors.primaryColor : Colors.black,
                fontWeight: FontWeight.w500,
                decoration: isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.task.subTitle,
                style: TextStyle(
                  color: isCompleted ? AppColors.primaryColor : Colors.black,
                  fontWeight: FontWeight.w300,
                  decoration: isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Column(
                    children: [
                      Text(
                        DateFormat('hh:mm a').format(widget.task.createdAtTime),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        DateFormat.yMMMEd().format(widget.task.createdAtDate),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    DateTime selectedDate = widget.task.createdAtDate;
    TimeOfDay selectedTime = TimeOfDay.fromDateTime(widget.task.createdAtTime);

    showDialog(
      context: context,
      builder:
          (_) => StatefulBuilder(
            builder:
                (context, setState) => AlertDialog(
                  title: const Text("Edit Task"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: titleController,
                        decoration: const InputDecoration(labelText: "Title"),
                      ),
                      TextField(
                        controller: subTitleController,
                        decoration: const InputDecoration(
                          labelText: "Subtitle",
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Date Picker Button
                      Row(
                        children: [
                          const Icon(Icons.calendar_today),
                          const SizedBox(width: 8),
                          TextButton(
                            onPressed: () async {
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: selectedDate,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (picked != null) {
                                setState(() => selectedDate = picked);
                              }
                            },
                            child: Text(
                              DateFormat.yMMMEd().format(selectedDate),
                            ),
                          ),
                        ],
                      ),

                      // Time Picker Button
                      Row(
                        children: [
                          const Icon(Icons.access_time),
                          const SizedBox(width: 8),
                          TextButton(
                            onPressed: () async {
                              final picked = await showTimePicker(
                                context: context,
                                initialTime: selectedTime,
                              );
                              if (picked != null) {
                                setState(() => selectedTime = picked);
                              }
                            },
                            child: Text(selectedTime.format(context)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        widget.task.title = titleController.text.trim();
                        widget.task.subTitle = subTitleController.text.trim();

                        // Update date & time
                        widget.task.createdAtDate = selectedDate;
                        widget.task.createdAtTime = DateTime(
                          selectedDate.year,
                          selectedDate.month,
                          selectedDate.day,
                          selectedTime.hour,
                          selectedTime.minute,
                        );

                        widget.task.save(); // Save to Hive
                        setState(() {}); // Update UI
                        Navigator.of(context).pop();
                      },
                      child: const Text("Save"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Cancel"),
                    ),
                  ],
                ),
          ),
    );
  }
}
