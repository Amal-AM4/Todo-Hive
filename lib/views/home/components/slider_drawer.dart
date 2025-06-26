import 'package:flutter/material.dart';
import 'package:todo/utils/app_colors.dart';

class CustomerDrawer extends StatelessWidget {
  const CustomerDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 90),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: AppColors.primaryGradientColor),
      ),
    );
  }
}
