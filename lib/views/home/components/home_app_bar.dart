import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:todo/utils/constants.dart';

SliderAppBar buildSliderAppBar(BuildContext context) {
  return SliderAppBar(
    config: SliderAppBarConfig(
      trailing: IconButton(
        onPressed: () {
          noTaskWarning(context);
        },
        icon: Icon(Icons.delete, color: Colors.red, size: 28),
      ),
      title: const Text(''),
    ),
  );
}

// var sliderAppBar = SliderAppBar(
//   config: SliderAppBarConfig(
//     // drawerIconColor: Colors.red,
//     // drawerIconSize: 32,
//     // backgroundColor: Colors.red,
//     trailing: IconButton(
//       onPressed: () {
//         emptyWarning(context);
//       },
//       icon: Icon(Icons.delete, color: Colors.red, size: 28),
//     ),
//     title: Text(''),
//   ),
// );
