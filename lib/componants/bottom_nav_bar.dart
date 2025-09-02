import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


// ignore: must_be_immutable
class MyBottomNavBar extends StatelessWidget {
  void Function(int)? onTabChange;
  MyBottomNavBar({super.key, required this.onTabChange, required int selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20,),
      color: Colors.white,
      //color: Theme.of(context).colorScheme.primary,
      child: GNav(
        color: Theme.of(context).colorScheme.inversePrimary,
        //backgroundColor: Theme.of(context).colorScheme.primary,
        activeColor: Colors.black ,
        tabActiveBorder: Border.all(color: Colors.white),
        tabBackgroundColor: Color.fromARGB(255, 247, 239, 209),
        mainAxisAlignment: MainAxisAlignment.center,
        tabBorderRadius: 16,
        onTabChange: (value) => onTabChange!(value),
        tabs: const [
        GButton(
        icon: Icons.home,
        text: ' My Clubs',
        ),
        GButton(
        icon: Icons.search,
        text: ' All Clubs',
        ),
        GButton(
        icon: Icons.volunteer_activism,
        text: ' Volunteer',
        ),
        GButton(
        icon: Icons.calendar_month,
        text: ' Calendar',
        ),
      ]),
    );
  }
}