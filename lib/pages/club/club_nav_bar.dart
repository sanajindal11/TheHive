import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


// ignore: must_be_immutable
class MyClubNavBar extends StatelessWidget {
  void Function(int)? onTabChange;
  MyClubNavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: GNav(
        color: Colors.grey[400],
        activeColor: Colors.black ,
        tabActiveBorder: Border.all(color: Colors.white),
        tabBackgroundColor: Colors.grey.shade100,
        mainAxisAlignment: MainAxisAlignment.center,
        tabBorderRadius: 16,
        onTabChange: (value) => onTabChange!(value),
        tabs: const [
        GButton(
        icon: Icons.home,
        text: ' Art',
        ),
        GButton(
        icon: Icons.message,
        text: ' Stream',
        ),
        GButton(
          icon: Icons.calendar_month,
          text: ' Calendar',
          )

        
      ]),
    );
  }
}