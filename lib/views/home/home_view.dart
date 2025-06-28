import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:lottie/lottie.dart';

import 'package:todo/extensions/space_exs.dart';
import 'package:todo/models/task.dart';
import 'package:todo/utils/app_colors.dart';
import 'package:todo/utils/app_str.dart';
import 'package:todo/utils/constants.dart';
import 'package:todo/views/home/components/fab.dart';
import 'package:todo/views/home/components/home_app_bar.dart';
import 'package:todo/views/home/components/slider_drawer.dart';
import 'package:todo/views/home/widgets/task_widget.dart';

import 'package:flutter/services.dart';

import 'package:animate_do/animate_do.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<int> testing = [1];
  final GlobalKey<SliderDrawerState> _sliderDrawerKey =
      GlobalKey<SliderDrawerState>();

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,

      floatingActionButton: const Fab(),

      body: SafeArea(
        child: SliderDrawer(
          key: _sliderDrawerKey,
          isDraggable: false,
          animationDuration: 1000,

          appBar: buildSliderAppBar(context),

          slider: CustomerDrawer(),
          child: _buildHomeBody(textTheme),
        ),
      ),
    );
  }

  // Home body
  Widget _buildHomeBody(TextTheme textTheme) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          // Custom App Bar
          Container(
            margin: const EdgeInsets.only(top: 10),
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
                    valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
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
            child:
                testing.isNotEmpty
                    // Task list is not empty
                    ? ListView.builder(
                      itemCount: testing.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          direction: DismissDirection.horizontal,
                          onDismissed: (_) {
                            // We will remove current task from db
                          },
                          background: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.delete_outline,
                                color: Colors.grey,
                              ),
                              8.w,
                              const Text(
                                AppStr.deleteTask,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          key: Key(index.toString()),
                          child: TaskWidget(
                            task: Task(
                              id: '1',
                              title: 'Home Task',
                              subTitle: 'Cleaning the room',
                              createdAtDate: DateTime.now(),
                              createdAtTime: DateTime.now(),
                              isCompleted: false,
                            ),
                          ),
                        );
                      },
                    )
                    // Task list is empty
                    : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Lottie Anime
                        FadeIn(
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            child: Lottie.asset(
                              lottieURL,
                              animate: testing.isNotEmpty ? false : true,
                            ),
                          ),
                        ),

                        FadeInUp(
                          from: 30,
                          child: const Text(AppStr.doneAllTask),
                        ),
                      ],
                    ),
          ),
        ],
      ),
    );
  }
}
