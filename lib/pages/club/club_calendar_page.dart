import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/componants/my_drawer.dart';
import 'package:flutter_application_1/pages/Calender_Widgits/date_picker.dart';
import 'package:flutter_application_1/pages/Calender_Widgits/event_tiles.dart';
import 'package:flutter_application_1/pages/Calender_Widgits/time_picker.dart';
import 'package:intl/intl.dart';

class ClubCalendarPage extends StatefulWidget {
  final String clubName;
  const ClubCalendarPage({super.key, required this.clubName});

  @override
  State<ClubCalendarPage> createState() => _ClubCalendarPageState();
}

class _ClubCalendarPageState extends State<ClubCalendarPage> {
  final List<List<String>> events = [
    ["event name", "date", "time", "location"],
  ];

  // Create a new event
  void createNewEvent() {
    final TextEditingController eventNameController = TextEditingController();
    final TextEditingController dateController = TextEditingController();
    final TextEditingController startTimeController = TextEditingController();
    final TextEditingController endTimeController = TextEditingController(); 
    final TextEditingController locationController = TextEditingController();

    DateTime? selectedDate;
    void updateSelectedDate(DateTime? newDate) {
    setState(() {
      selectedDate = newDate;
      dateController.text = newDate != null ? "${newDate.toLocal()}".split(' ')[0] : '';
    });
  }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Create a new event"),
          content: Container(
            height: 406,
            child: Column(
              children: [
                TextField(
                  controller: eventNameController,
                  decoration:  InputDecoration(
                    labelText: "Event Name",
                    labelStyle: TextStyle(fontSize: 18, color: Colors.grey.shade800)
                  ),
                ),
                SizedBox(height: 10),
                DatePicker(onDateSelected: updateSelectedDate),
                Row(
                  children: [
                    Text("Start Time"),
                    SizedBox(width: 100,),
                    TimePicker(onTimeSelected: (TimeOfDay selectedTime) {
                      startTimeController.text = selectedTime.format(context);
                    }),             
                  ],
                ),
                SizedBox(
                  height: 20,
                  child: TextField(
                    controller: startTimeController,
                  ),
                ),
                Row(
                  children: [
                    Text("End Time"),
                    SizedBox(width: 108,),
                    TimePicker(onTimeSelected: (TimeOfDay selectedTime) {
                      endTimeController.text = selectedTime.format(context);
                    }),
                  ],
                ),
                SizedBox(
                  height: 17,
                  child: TextField(
                    controller: endTimeController,
                  ),
                ),
                TextField(
                  controller: locationController,
                  decoration: InputDecoration(
                    labelText: "Location",
                    labelStyle: TextStyle(fontSize: 18, color: Colors.grey.shade800)
                  ),
                ),
              ],
            ),
          ),
          actions: [
          TextButton(
            onPressed: () {
              // Validate fields before proceeding
              if (eventNameController.text.isEmpty ||
                  selectedDate == null ||
                  startTimeController.text.isEmpty ||
                  locationController.text.isEmpty) {
                // Show an alert if any required field is empty
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('All fields are required!')),
                );
              } else {
                // Save the event to Firestore
                saveEventToFirestore(
                  eventNameController.text,
                  selectedDate!,
                  startTimeController.text,
                  endTimeController.text, 
                  locationController.text,
                );
                // Close the dialog
                Navigator.of(context).pop();
              }
            },
            child: const Text("Add Event",
            style: TextStyle(color: Color.fromARGB(255, 70, 58, 36))
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel",
            style: TextStyle(color: Color.fromARGB(255, 70, 58, 36))
            ),
          ),
        ],
        );
      },
      
    );
  }

  // Delete event from Firestore 
void deleteTask(String eventName) {
  // Get the event name from the event at the given index
  print("Attempting to delete event: $eventName");

  // Delete the event from Firestore
  FirebaseFirestore.instance.collection('events').doc(eventName).delete().then((_) {
    print('Event "$eventName" deleted from Firestore');
  }).catchError((error) {
    print('Failed to delete event from Firestore: $error');
  });
}


  // Save event to Firestore
  void saveEventToFirestore(String eventName, DateTime eventDate, String startTime, String endTime, String eventLocation) {
  final eventCollection = FirebaseFirestore.instance
  .collection('club')
  .doc(widget.clubName)
  .collection('clubEvents')
  .doc(eventName);
  
  eventCollection.set({
    'eventName': eventName,
    'eventDate': eventDate,
    'startTime': startTime,
    'endTime': endTime,
    'eventLocation': eventLocation,
  }).then((value) {
    print('Event added to Firestore');
  }).catchError((error) {
    print('Failed to add event: $error');
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: FloatingActionButton(
        onPressed: createNewEvent,
        backgroundColor: Color.fromARGB(255, 238, 227, 196),
        child: Icon(Icons.add, color: Colors.black,),
      ),
      drawer: const MyDrawer(),
      body: 
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text("C A L E N D A R", style: TextStyle(fontSize: 20),),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                .collection('club')
                .doc(widget.clubName)
                .collection('clubEvents')
                .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                
                  final eventsData = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: eventsData.length,
                    itemBuilder: (context, index) {
                      var event = eventsData[index];
                      return EventTile(
                        eventName: event['eventName'],
                        eventDate: DateFormat('dd/MM/yyyy').format(event['eventDate'].toDate()),
                        startTime: event['startTime'],
                        endTime: event['endTime'],
                        eventLocation: event['eventLocation'],
                        deleteFunction: (context) => deleteTask(event['eventName']),
                      );
                    },
                  );
                },
                        ),
              ),
            ],
          ),
    );
  }
}