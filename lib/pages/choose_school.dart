import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/componants/my_button.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChooseSchoolPage extends StatefulWidget {
  ChooseSchoolPage({super.key});

  @override
  State<ChooseSchoolPage> createState() => _ChooseSchoolPageState();
}

class _ChooseSchoolPageState extends State<ChooseSchoolPage> {
  String? selectedSchool = '';
  String? userId = FirebaseAuth.instance.currentUser?.email;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void saveSchoolToFirestore(String school) async {
  //String? userId = FirebaseAuth.instance.currentUser?.email;
  if (userId == null) return; // Ensure user is logged in

  try {
    await _firestore.collection('Users').doc(userId).set({
      'selectedSchool': school,
      'timestamp': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
    print("School saved successfully!");
  } catch (e) {
    print("Error saving school: $e");
  }

}
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("T H E   H I V E"),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 150.0, bottom: 10.0),
              child: Text(
                'Select School:',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontSize: 23
                ),
              ),
            ),
          DropdownMenu<String>(
            enableSearch: true,
            enableFilter: true,
            requestFocusOnTap: true,
            hintText: 'Select School',
            menuHeight: 300,
            width: 310,
            initialSelection: selectedSchool,
            onSelected: (String? newValue) {
              setState(() {
                print(selectedSchool);
                selectedSchool = newValue;
              });
              saveSchoolToFirestore(newValue!); // Save to Firestore
            },
            dropdownMenuEntries: <DropdownMenuEntry<String>>[
              DropdownMenuEntry(value: '-', label: 'Select School'),
              DropdownMenuEntry(value: 'Portage Central High School', label: 'Portage Central High School'),
              DropdownMenuEntry(value: 'Portage Northern High School', label: 'Portage Northern High School'),
              DropdownMenuEntry(value: 'Kalamazoo Central High School', label: 'Kalamazoo Central High School'),
              DropdownMenuEntry(value: 'Loy Norrix High School', label: 'Loy Norrix High School'),
              DropdownMenuEntry(value: 'Mattawan High School', label: 'Mattawan High School'),
              DropdownMenuEntry(value: 'Gull Lake High School', label: 'Gull Lake High School'),
              DropdownMenuEntry(value: 'Vicksburg High School', label: 'Vicksburg High School'),
              DropdownMenuEntry(value: 'Schoolcraft High School', label: 'Schoolcraft High School'),
              ]
            ), 
             Padding(
                padding: const EdgeInsets.all(37.0),
                child: MyButton(
                  text: "Next",
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  ),
              ),
        ],
        ),
        
        
      ),
    );
  }
}