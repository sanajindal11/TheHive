
// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  HelpPage({super.key});

  String? userId = FirebaseAuth.instance.currentUser?.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("H E L P   C E N T E R"), 
        elevation: 0, 
        actions: [
          Row(
            children: [
              Image.asset(
                'lib/images/logo.png',
                height: 50,
              ),
              const SizedBox(width: 10),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 18, left: 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 13),
                  child: 
                  Text( 
                    'Frequently Asked Questions:',
                    style: TextStyle(
                        color: Color(0xFF6D5B38),
                        fontSize: 23, 
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                  ),
                ),
                // First ExpansionTile that is collapsible
                ExpansionTile(
                  // The title of the expandable section
                  title: Text(
                    'How to Change Schools',
                    style: TextStyle(
                      color: Color(0xFF6D5B38),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // The content that appears when the tile is expanded
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5), // Padding inside the tile
                          child: Text(
                            'Changing schools requires approval from a school administrator, which may take some time to process.',
                            style: TextStyle(
                              color: Color(0xFF6D5B38), // Color of text based on surface color of the theme
                              fontSize: 16,
                            ),
                          ),
                        ),
                        // Button to change schools
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: ListTile(
                            leading: Icon(
                              Icons.school,
                              color: Theme.of(context).colorScheme.inversePrimary,
                            ),
                            title: Text(
                              'Change School',
                              style: TextStyle(color: Color(0xFF6D5B38)),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(context, '/choose_school');
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10, // Space between expansion tiles
                ),
                // Second ExpansionTile with similar functionality
                ExpansionTile(
                  title: Text(
                    'How to Create a Club',
                    style: TextStyle(
                      color: Color(0xFF6D5B38), 
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // The content that appears when the tile is expanded
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0), // Padding inside the tile
                      child: Text(
                        '1. Navigate to the sidebar and select "Create a Club".\n2. Enter the required information in the provided fields (Name, Description, Club Advisor, and Email).\n3. Click Submit.',
                        style: TextStyle(
                          color: Color(0xFF6D5B38), // Color of text based on surface color of the theme
                          fontSize: 16, // Font size of the content text
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10, // Space after the second expansion tile
                ),
                // Third ExpansionTile with similar functionality
                ExpansionTile(
                  title: Text(
                    'Managing Your Clubs',
                    style: TextStyle(
                      color: Color(0xFF6D5B38), // Primary color from the theme
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // The content that appears when the tile is expanded
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0), // Padding inside the tile
                      child: Column(
                        children: [ Text(
                            'Join a Club:',
                            style: TextStyle(
                              color: Color(0xFF6D5B38), // Color of text based on surface color of the theme
                              fontSize: 18, // Font size of the content text
                            ),
                          ),
                          Text(
                            '1. Navigate to sidebar and select "All Clubs"to view a list of all available clubs at your school.\n2. Select your desired club from the list.\n3. Click the plus icon in the top right corner to add the club to your homepage.\n\nThis will also integrate the club\'s calendar with your personal calendar.\n\n',
                            style: TextStyle(
                              color: Color(0xFF6D5B38), // Color of text based on surface color of the theme
                              fontSize: 16, // Font size of the content text
                            ),
                          ),
                          Text(
                            'Leave a Club:',
                            style: TextStyle(
                              color: Color(0xFF6D5B38), // Color of text based on surface color of the theme
                              fontSize: 18, // Font size of the content text
                            ),
                          ),
                          Text(
                            '1. Select the club you wish to remove from your homepage or all clubs page.\n2. Click the plus icon to leave a club you are currently a member of.',
                            style: TextStyle(
                              color: Color(0xFF6D5B38), // Color of text based on surface color of the theme
                              fontSize: 16, // Font size of the content text
                            ),
                          ),
                        ],
                      )
                    ),
                  ],
                ),
                SizedBox(
                  height: 10, // Space after the second expansion tile
                ),
                // Third ExpansionTile with similar functionality
                ExpansionTile(
                  title: Text(
                    'How to Create Events',
                    style: TextStyle(
                      color: Color(0xFF6D5B38), // Primary color from the theme
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // The content that appears when the tile is expanded
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0), // Padding inside the tile
                      child: Column(
                        children: [ 
                          Text(
                            '1. Click the plus button located at the bottom right corner of either the Volunteer or Calendar page.\n2. Complete the required fields with the necessary information.\n3. Select "Add Event" to finalize your entry.',
                            style: TextStyle(
                              color: Color(0xFF6D5B38), // Color of text based on surface color of the theme
                              fontSize: 16, // Font size of the content text
                            ),
                          ),
                        ],
                      )
                    ),
                  ],
                ),
                // Page Divider 
                Divider(
                    height: 100,
                    color: Colors.brown,
                    thickness: 1,
                    indent : 10,
                    endIndent : 10,       
                ),
                Text(
                    'Help Center:',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontSize: 24,
                        fontWeight: FontWeight.bold, 
                        ),
                    textAlign: TextAlign.left,
                  ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    '\nWe would love to hear from you. Please email us to report bugs or share feedback',
                    style: TextStyle(
                        color: Color(0xFF6D5B38),
                        fontSize: 18),
                    textAlign: TextAlign.center, 
                  ),
                ),
                SizedBox(
                  height: 20, 
                ),
                // A button to email the team
                ElevatedButton.icon(
                  onPressed: () {
                    // Action for button press, add your logic here
                  },
                  icon: const Icon(
                    Icons.email, // Email icon in the button
                    color: Color(0xFF6D5B38), // Custom icon color
                  ),
                  label: Text(
                    "Email Us", // Button label
                    style: TextStyle(color: Color(0xFF6D5B38)), // Label color
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 250, 240, 213) // Background color of the button
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
