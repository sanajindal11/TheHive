import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/choose_school.dart';
import 'package:flutter_application_1/pages/create_a_club.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  // logout user
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.inverseSurface,
      child: Column(
        children: [
          // Top section (Logo and Main Items)
          Column(
            children: [
              DrawerHeader(
                child: Image.asset(
                  'lib/images/logo.png',
                ),
              ),

              // Profile Page
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  title: Text(
                    'P R O F I L E',
                    style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/profile_page');
                  },
                ),
              ),

              // Create a Club
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.add,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  title: Text(
                    'C R E A T E  A  C L U B',
                    style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/create_a_club');
                  },
                ),
              ),

              // Divider
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(color: Colors.grey[800]),
              ),

              // Home
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  title: Text(
                    'H O M E',
                    style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/home_page');
                  },
                ),
              ),

              // All Clubs
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  title: Text(
                    'A L L  C L U B S',
                    style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/search_page');
                  },
                ),
              ),
               // volunteer
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.volunteer_activism,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  title: Text(
                    'V O L U N T E E R',
                    style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/volunteer_page');
                  },
                ),
              ),

              // Calendar
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.calendar_month,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  title: Text(
                    'C A L E N D A R',
                    style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/calendar_page');
                  },
                ),
              ),
            ],
          ),

          // Push the last items to the bottom
          const Spacer(),

          // Bottom section (Help, Change Schools, Logout)
          Column(
            children: [
              // Help
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.help,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  title: Text(
                    'Help',
                    style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/help_page');
                  },
                ),
              ),

              // Logout
              Padding(
                padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  title: Text(
                    'Logout',
                    style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    logout();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
