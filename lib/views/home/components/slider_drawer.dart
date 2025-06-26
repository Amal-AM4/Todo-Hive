import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/extensions/space_exs.dart';
import 'package:todo/utils/app_colors.dart';

class CustomerDrawer extends StatelessWidget {
  CustomerDrawer({super.key});

  // Icons
  final List<IconData> icons = [
    CupertinoIcons.home,
    CupertinoIcons.person_fill,
    CupertinoIcons.settings,
    CupertinoIcons.info_circle_fill,
  ];

  // Texts
  final List<String> texts = ["Home", "Profile", "Settings", "Details"];

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 90),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.primaryGradientColor,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),

      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
              "https://avatars.githubusercontent.com/u/91388754?v=4",
            ),
          ),
          8.h,
          Text('Amal A M', style: textTheme.displayMedium),
          Text('Flutter dev', style: textTheme.displaySmall),

          Container(
            width: double.infinity,
            height: 300,
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: ListTile(
                    leading: Icon(icons[index]),
                    title: Text(texts[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
