import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // current logged in user
  User? currentUser = FirebaseAuth.instance.currentUser;

  // future to fetch user detials
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetials() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null || currentUser.email == null) {
      throw Exception("User is not logged in or email is unavailable.");
    }

    print("Fetching details for email: ${currentUser.email}");

    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser.email) // Ensure your Firestore uses email as the document ID
        .get();
  }

  //profile picture 
  Uint8List? pickedImage; 
  @override
  void initState() {
    super.initState();
    getProfilePicture();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("P R O F I L E"),
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
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: getUserDetials(),
            builder: (context, snapshot) {
              // loading..
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              // error
              else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              }
              // data received
              else if (snapshot.hasData) {
                // extract data
                Map<String, dynamic>? user = snapshot.data!.data();
                if (user == null) {
                  return const Text("No user data found");
                }
                return Padding(
                  padding: const EdgeInsets.only(top:170),
                  child: Center(
                    child: Column(      
                      children: [
                        // profile picture 
                        GestureDetector(
                          //onTap: onProfileTapped,
                          child: Container(
                            height: 150,
                            width: 150, 
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 238, 227, 196), 
                              shape: BoxShape.circle,
                              image: pickedImage != null
                                  ? DecorationImage(
                                      fit: BoxFit.cover,
                                      image: Image.memory(
                                        pickedImage!,    //added something here
                                        fit: BoxFit.cover,
                                      ).image,
                                    )
                                  : null, 
                            ),
                            child:  Center(
                              child: Icon(
                                Icons.person_rounded,
                                color: Colors.white,
                                size: 60, 
                                ),
                              )
                          ),
                        ),
                        // user information 
                        SizedBox(height: 20),
                        Text(
                          user['username'] ?? 'No username available',
                          style: TextStyle(fontSize: 25), // Adjust
                        ),
                        Text(
                          user['selectedSchool'] ?? 'No school available',
                          style: TextStyle(fontSize: 15),
                          ),
                        Text(
                          user['email'] ?? 'No email available',
                          style: TextStyle(fontSize: 15),
                          ),
                        
                        //Text(user['email'] ?? 'No email available'),
                      ],
                    ),
                  ),
                );
              } else {
                return const Text("No data");
              }
            },
          ),
          
        ],
      )
    );
  }

  // Profil picture helper methods 
  Future<void> onProfileTapped() async {
    // allowing user to pick an image 
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery); 
    if(image == null) return; 

    // uploading chosen image to firebase ---- this may need to be changed 
    final storageRef = FirebaseStorage.instance.ref(); 
    final imageRef = storageRef.child("user_1.jpg");//change "" that to the ID of the authenticated user in app 
    final imageBytes = await image.readAsBytes(); 
    await imageRef.putData(imageBytes); 

    setState(() => pickedImage = imageBytes);
  }
  Future<void> getProfilePicture() async {
    final storageRef = FirebaseStorage.instance.ref(); 
    final imageRef = storageRef.child('user_1.jpg');// again may need to fix this 

    try {
      final imageBytes = await imageRef.getData(); 
      if(imageBytes == null) return; 
      setState(() => pickedImage = imageBytes);
    } catch (e) {
      print('Profile picture cound not be found');
    }
  }
}
