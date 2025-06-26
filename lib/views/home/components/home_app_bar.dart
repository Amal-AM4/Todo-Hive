import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

var sliderAppBar = SliderAppBar(
  config: SliderAppBarConfig(
    // drawerIconColor: Colors.red,
    // drawerIconSize: 32,
    // backgroundColor: Colors.red,
    trailing: IconButton(
      onPressed: () {
        log('delete btn');
      },
      icon: Icon(Icons.delete, color: Colors.red, size: 28),
    ),
    title: Text(''),
  ),
);
