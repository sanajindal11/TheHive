
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/componants/expandable_text_field.dart';
import 'package:flutter_application_1/componants/icon_dropdown.dart';
import 'package:flutter_application_1/componants/my_button.dart';
import 'package:flutter_application_1/pages/home_page.dart';

class CreateAClub extends StatefulWidget {
   const CreateAClub({super.key});

  @override
  _CreateAClubState createState() => _CreateAClubState();
}

class _CreateAClubState extends State<CreateAClub> {
  final clubNameController = TextEditingController();
  final clubDesController = TextEditingController(); 
  final clubAdvisorController = TextEditingController(); 
  final clubEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('A D D   A   C L U B'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 160.0),
                child: Text(
                  'Name of the Club:',
                  style: TextStyle(
                    color: Color(0xFF62553B),
                    fontSize: 23
                    ),
                ),
              ),
              TextField(
                controller: clubNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0, right: 230.0, bottom: 0.0),
                child: Text(
                  'Description:',
                  style: TextStyle(
                    color: Color(0xFF62553B),
                    fontSize: 23
                    ),
                ),
              ),
              ExpandableTextField(
                hint: '',
                controller: clubDesController,
                //controller: TextEditingController(),
                ),
              Padding(
                padding: const EdgeInsets.only(right: 210.0, bottom: 0.0),
                child: Text(
                  'Club Advisor:',
                  style: TextStyle(
                    color: Color(0xFF62553B),
                    fontSize: 23
                    ),
                ),
              ),
              TextField(
                controller: clubAdvisorController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '',
                ),
                enableInteractiveSelection: true,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25, right: 300.0, bottom: 0.0),
                child: Text(
                  'Email:',
                  style: TextStyle(
                    color: Color(0xFF62553B),
                    fontSize: 23
                    ),
                ),
              ),
              TextField(
                controller: clubEmailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '',
                  counterStyle: TextStyle(
                    color: Colors.grey[200],
                  ),
                ),
                enableInteractiveSelection: true,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:25.0),
                child: TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Color(0xFF62553B)), 
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Placeholder()),
                    );
                    
                  },
                child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 25),
                child: /*MyButton(
                  text: "Submit",
                  onTap: Placeholder.new,
                  ),*/
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all<Color>(Color(0xFF62553B)), 
                    ),
                    onPressed: () {
                      DocumentReference<Map<String, dynamic>> collRef = FirebaseFirestore.instance.collection('club').doc(clubNameController.text);
                      collRef.set({
                        'clubName': clubNameController.text,
                        'clubDes': clubDesController.text,
                        'clubAdvisor': clubAdvisorController.text,
                        'clubEmail': clubAdvisorController.text,
                      }
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HomePage()),
                      );
                    },
                    child: Card(
                      color:  Color(0xFFE1D8B9),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 93),
                        child: Text(
                          'Submit',
                          style: TextStyle(fontSize: 23),
                        ),
                      ),
                    ),
                  ),
              ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}