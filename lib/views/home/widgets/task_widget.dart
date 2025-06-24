import 'package:flutter/material.dart';
import 'package:todo/utils/app_colors.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to Task View to see Task Details
      },
      child: AnimatedContainer(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: const Color.fromARGB(30, 69, 104, 220),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(10, 0, 0, 0),
              offset: const Offset(0, 4),
              blurRadius: 10,
            ),
          ],
        ),
        duration: const Duration(milliseconds: 600),

        child: ListTile(
          // check icon
          leading: GestureDetector(
            onTap: () {
              // check or uncheck the task
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              width: 30, // ✅ specify width
              height: 30, // ✅ specify height
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey, width: .8),
              ),
              child: const Icon(Icons.check, color: Colors.white),
            ),
          ),

          // Task title
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5, top: 3),
            child: const Text(
              "Done",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // Task subtitle
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Descrption',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w300,
                ),
              ),

              // Date of Task
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Date",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),

                      Text(
                        "SubDate",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
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
}
