import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/componants/my_button.dart';
import 'package:flutter_application_1/pages/Calender_Widgits/date_picker.dart';
import 'package:flutter_application_1/pages/calendar_page.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class VolunteerEventTile extends StatelessWidget {
  final String eventName;
  final String eventDes;
  final String eventDate;
  final String startTime;
  final String endTime;
  final int numberOfPeople;
  final String eventLocation;
  Function(BuildContext)? deleteFunction;

  VolunteerEventTile({
    super.key,
    required this.eventName,
    required this.eventDes,
    required this.eventDate,
    required this.startTime,
    required this.endTime,
    required this.numberOfPeople,
    required this.eventLocation,
    required this.deleteFunction,
  });

  User? currentUser = FirebaseAuth.instance.currentUser;
  // Save event to Firestore
  void addEventToMyCalendar(
    String eventName,
    String eventDes,
    DateTime eventDate,
    String startTime, 
    String endTime, 
    int numberOfPeople, 
    String eventLocation) {

  final eventCollection = FirebaseFirestore.instance
  .collection('Users')
  .doc(currentUser!.email)
  .collection('myVolunteerEvents')
  .doc(eventName);
  
  eventCollection.set({
    'eventName': eventName,
    'eventDes' : eventDes,
    'eventDate': eventDate,
    'startTime': startTime,
    'endTime': endTime,
    'numberOfPeople': numberOfPeople,
    'eventLocation': eventLocation,
  }).then((value) {
    print('Event added to Firestore');
  }).catchError((error) {
    print('Failed to add event: $error');
    //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add event: $error')));
  });
}
// Function to update the number of people in Firestore
  void decrementNumberOfPeople() {
    if (numberOfPeople > 0) {
      FirebaseFirestore.instance
          .collection('volunteer')
          .doc(eventName)
          .update({'numberOfPeople': numberOfPeople - 1}).then((_) {
        print("Number of people updated!");
      }).catchError((error) {
        print("Failed to update number of people: $error");
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      color: Color.fromARGB(255, 250, 240, 213),
      elevation: 5,
        child: Slidable(
          endActionPane: ActionPane(
             motion: StretchMotion(),
             children: [
                SlidableAction(
                  onPressed: deleteFunction,
                  icon: Icons.delete,
                  backgroundColor: Colors.red.shade300,
                  borderRadius: BorderRadius.circular(12),
              ),
             ],
             ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(15),
            title: Text(
              eventName,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Description: $eventDes',
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Date: $eventDate',
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Start Time: $startTime - $endTime',
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Number of People: $numberOfPeople',
                    style: const TextStyle(
                      fontSize: 14,
                      ),
                    ),
                Text(
                  'Location: $eventLocation',
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            trailing: const Icon(Icons.add),
            onTap: () {
              addEventToMyCalendar(eventName, eventDes, DateFormat('MM/dd/yyyy').parse(eventDate), startTime, endTime, numberOfPeople, eventLocation);
              
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Event added'))
              );
              
              // reduce the number of people 
              decrementNumberOfPeople();
               
              // take you to the calendar page 
              /*Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CalendarPage()),
              );*/
              
              print("Event added to Firestore");
            },
          ),
        ),
      
    );
  }
}