import 'package:flutter/material.dart';
import 'package:flutter_application_1/componants/bottom_nav_bar.dart';
import 'package:flutter_application_1/pages/help_page.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/volunteer_page.dart';

import 'calendar_page.dart';
import 'search_page.dart';

class SideBarPage extends StatefulWidget {
  const SideBarPage({super.key});

  @override
  State<SideBarPage> createState() => _SideBarPageState();
}

class _SideBarPageState extends State<SideBarPage> {
  int _selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> pages = [
    const HomePage(),
    const SearchPage(),
    VolunteerPage(),
    CalendarPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      bottomNavigationBar: MyBottomNavBar(
        selectedIndex: _selectedIndex, // Pass index
        onTabChange: navigateBottomBar,
      ),

      body: IndexedStack( // Keeps pages in memory
        index: _selectedIndex,
        children: pages,
      ),
    );
  }
}
