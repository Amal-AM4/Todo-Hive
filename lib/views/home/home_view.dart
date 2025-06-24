import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo/extensions/space_exs.dart';
import 'package:todo/utils/app_colors.dart';
import 'package:todo/utils/app_str.dart';
import 'package:todo/views/home/components/fab.dart';
import 'package:todo/views/home/widgets/task_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,

      floatingActionButton: const Fab(),

      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            // Custom App Bar
            Container(
              margin: const EdgeInsets.only(top: 60),
              width: double.infinity,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      value: 1 / 4,
                      backgroundColor: Colors.grey,
                      valueColor: AlwaysStoppedAnimation(
                        AppColors.primaryColor,
                      ),
                    ),
                  ),
                  // space
                  25.w,

                  // Top lvl Task info
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppStr.mainTitle, style: textTheme.displayLarge),
                      3.h,
                      Text(
                        '1 of 3 task',
                        style: textTheme.titleMedium,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Divider
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Divider(thickness: 2, indent: 0),
            ),

            // Tasks
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Dismissible(
                    direction: DismissDirection.horizontal,
                    onDismissed: (_) {
                      // We will remove current task from db
                    },
                    background: Row(
                      children: [
                        Icon(Icons.delete_outline, color: Colors.grey),
                      ],
                    ),
                    key: Key(index.toString()),
                    child: const TaskWidget(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
