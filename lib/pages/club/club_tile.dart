import 'package:flutter/material.dart';
import 'package:flutter_application_1/componants/my_button.dart';
import 'package:flutter_application_1/pages/Calender_Widgits/date_picker.dart';
import 'package:flutter_application_1/pages/club/club_home_page.dart';
import 'package:flutter_application_1/pages/club/club_outline.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';


class ClubTile extends StatelessWidget {
  final String clubName;
  final String clubDescription;
  final String clubAdvisor;
  final String clubEmail;

  ClubTile({
    super.key,
    required this.clubName,
    required this.clubDescription,
    required this.clubAdvisor,
    required this.clubEmail,
  });



  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      color: Color.fromARGB(255, 250, 240, 213),
      elevation: 5,
          child: ListTile(
            contentPadding: const EdgeInsets.all(25),
            leading: const Icon(Icons.donut_large_outlined),
            title: Text(
              clubName,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
                      //pop drawer
                      Navigator.pop(context);
                
                     // Navigate to the ClubOutline page with clubName as an argument
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ClubOutline(
                            clubName: clubName,
                            clubDescription: clubDescription,
                            clubAdvisor: clubAdvisor,
                            clubEmail: clubEmail,
                          ),
                        ),
                      );
                    },
            
          ),
        
      
    );
  }
}