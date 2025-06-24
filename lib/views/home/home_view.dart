import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo/utils/app_colors.dart';
import 'package:todo/views/home/widgets/fab.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      floatingActionButton: Fab(),
    );
  }
}

