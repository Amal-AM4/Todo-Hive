import 'package:flutter/material.dart';

class HomeAppBar extends StatefulWidget {
  final VoidCallback onMenuTap; // 👈 Add this

  const HomeAppBar({super.key, required this.onMenuTap});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController animateController;
  bool isDrawerOpen = false;

  @override
  void initState() {
    animateController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    super.initState();
  }

  @override
  void dispose() {
    animateController.dispose();
    super.dispose();
  }

  void onDrawerToggle() {
    setState(() {
      isDrawerOpen = !isDrawerOpen;
      if (isDrawerOpen) {
        animateController.forward();
      } else {
        animateController.reverse();
      }
    });

    widget.onMenuTap(); // 👈 Call the parent toggle
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 130,
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: IconButton(
                onPressed: onDrawerToggle,
                icon: AnimatedIcon(
                  icon: AnimatedIcons.menu_close,
                  progress: animateController,
                  size: 40,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
