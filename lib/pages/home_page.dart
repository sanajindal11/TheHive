import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/componants/bottom_nav_bar.dart';
import 'package:flutter_application_1/componants/my_drawer.dart';
import 'package:flutter_application_1/pages/club/club_outline.dart';
import 'package:flutter_application_1/pages/club/club_tile.dart';
import 'package:flutter_application_1/pages/side_bar_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("H O M E"),
        elevation: 0,
         actions: [
          Row(
            children: [
              Image.asset(
                'lib/images/logo.png',
                height: 50,
              ),
              SizedBox(width: 8,)
            ],
          ),
        ],
      ),
      drawer: const MyDrawer(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Users').doc(currentUser?.email).collection('joinedClubs')
            .snapshots(), // Stream to listen to changes in Firebase
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong!'));
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No clubs added yet.'));
          }

          final clubs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: clubs.length,
            itemBuilder: (context, index) {
              var clubData = clubs[index];
              return ClubTile(
              clubName: clubData['clubName'],
              clubDescription: clubData['clubDescription'],
              clubAdvisor: clubData['clubAdvisor'],
              clubEmail: clubData['clubEmail'],
            );
            },
          );
        },
      ),
      
      
    );
  }
}