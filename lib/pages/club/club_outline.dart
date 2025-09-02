import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/club/club_nav_bar.dart';
import 'package:flutter_application_1/pages/club/PostStream/posts_stream_page.dart';
import 'package:flutter_application_1/pages/club/club_calendar_page.dart';
import '../../componants/my_drawer.dart';
import 'club_home_page.dart';

class ClubOutline extends StatefulWidget {
  final String clubName;
  final String clubDescription;
  final String clubAdvisor;
  final String clubEmail;

  const ClubOutline({
    super.key,
    required this.clubName,
    required this.clubDescription,
    required this.clubAdvisor,
    required this.clubEmail,
  });

  @override
  State<ClubOutline> createState() => _ClubOutlineState();
}

class _ClubOutlineState extends State<ClubOutline> {

  User? currentUser = FirebaseAuth.instance.currentUser;
  int _selectedIndex = 0;
  bool isNotified = false;
  bool isJoined = false;

  // Add this method to save club details to Firebase when the user joins a club
  /*Future<void> joinClub() async {
    final clubRef = FirebaseFirestore.instance.collection('Users').doc(currentUser?.email).collection('joinedClubs');
    final existingClubsQuery = await clubRef
        .where('clubName', isEqualTo: widget.clubName)
        .get();

    // If club already exists, don't add it
    if (existingClubsQuery.docs.isEmpty) {
      clubRef.add({
        'clubName': widget.clubName,
        'clubDescription': widget.clubDescription,
        'clubAdvisor': widget.clubAdvisor,
        'clubEmail': widget.clubEmail,
      });
    } else {
      // Show a message if the club already exists
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('This club is already added!')),
      );
    }
  }*/
  Future<void> joinClub() async {
  final clubRef = FirebaseFirestore.instance
      .collection('Users')
      .doc(currentUser?.email)
      .collection('joinedClubs')
      .doc(widget.clubName); // Use clubName as the document ID

  final clubDoc = await clubRef.get();

  if (!clubDoc.exists) {
    await clubRef.set({
      'clubName': widget.clubName,
      'clubDescription': widget.clubDescription,
      'clubAdvisor': widget.clubAdvisor,
      'clubEmail': widget.clubEmail,
    });
  } else {
    // Show a message if the club already exists
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('This club is already added!')),
    );
  }
}



  void navigateBottomBar (int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          widget.clubName,
        ),
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: Icon(isJoined ? Icons.check : Icons.add),
            //onPressed: joinClub,
            onPressed: () {
            joinClub();
            setState(() {
              isJoined = !isJoined;
            });
          },

          ),
        IconButton(
          icon: Icon(isNotified ? Icons.notifications_active : Icons.notification_add),
          onPressed: () {
            setState(() {
              isNotified = !isNotified;
            });
          },
        ),
        ],
      ),
      
      drawer: const MyDrawer(),
      bottomNavigationBar : MyClubNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          ClubHomePage(
            clubName: widget.clubName,
            clubDescription: widget.clubDescription,
            clubAdvisor: widget.clubAdvisor,
            clubEmail: widget.clubEmail,
          ),
          PostsStreamPage(
            clubName: widget.clubName,
            ),
          ClubCalendarPage(
            clubName: widget.clubName,
          ),
        ],
      ),
    );
  }
}
