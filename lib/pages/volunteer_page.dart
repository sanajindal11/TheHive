import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/componants/bottom_nav_bar.dart';
import 'package:flutter_application_1/componants/my_drawer.dart';
import 'package:flutter_application_1/pages/Calender_Widgits/date_picker.dart';
import 'package:flutter_application_1/pages/Calender_Widgits/time_picker.dart';
import 'package:flutter_application_1/pages/club/club_outline.dart';
import 'package:flutter_application_1/pages/club/club_tile.dart';
import 'package:flutter_application_1/pages/side_bar_page.dart';
import 'package:flutter_application_1/pages/volunteer_event_tile.dart';
import 'package:intl/intl.dart';

class VolunteerPage extends StatefulWidget {
  const VolunteerPage({super.key});

  @override
  State<VolunteerPage> createState() => _VolunteerPageState();
}

class _VolunteerPageState extends State<VolunteerPage> {
  User? currentUser = FirebaseAuth.instance.currentUser;

  void createNewVolunteerEvent() {
  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController eventDesController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  final TextEditingController numberOfPeopleController = TextEditingController();
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
          height: 444,
          child: Column(
            children: [
              TextField(
                controller: eventNameController,
                decoration:  InputDecoration(
                  labelText: "Event Name",
                  labelStyle: TextStyle(fontSize: 12, color: Colors.grey.shade800),
                ),
              ),
              TextField(
                controller: eventDesController,
                decoration:  InputDecoration(
                  labelText: "Event Description",
                  labelStyle: TextStyle(fontSize: 12, color: Colors.grey.shade800),
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
                controller: numberOfPeopleController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Number of People Needed",
                  labelStyle: TextStyle(fontSize: 12, color: Colors.grey.shade800),
                ),
              ),
              TextField(
                controller: locationController,
                decoration: InputDecoration(
                  labelText: "Location",
                  labelStyle: TextStyle(fontSize: 12, color: Colors.grey.shade800),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Validate required fields
              if (eventNameController.text.isEmpty ||
                  eventDesController.text.isEmpty ||
                  selectedDate == null ||
                  startTimeController.text.isEmpty ||
                  endTimeController.text.isEmpty || 
                  numberOfPeopleController.text.isEmpty || 
                  locationController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('All fields are required!')),
                );
                return; // Exit the function if fields are empty
              }

              // Check for valid number of people
              int? numberOfPeople = int.tryParse(numberOfPeopleController.text);
              if (numberOfPeople == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Number of people must be a valid number!')),
                );
                return;
              }

              // Validate time fields are not empty
              if (startTimeController.text.isEmpty || endTimeController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Start time and End time cannot be empty!')),
                );
                return;
              }

              // Try to parse the times to validate their format
              try {
                // Parse the time strings into DateTime objects
                final startTime = TimeOfDay.fromDateTime(DateFormat("hh:mm a").parse(startTimeController.text));
                final endTime = TimeOfDay.fromDateTime(DateFormat("hh:mm a").parse(endTimeController.text));

                // Ensure start time is earlier than end time
                if (startTime.hour > endTime.hour ||
                    (startTime.hour == endTime.hour && startTime.minute >= endTime.minute)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Start time must be earlier than end time!')),
                  );
                  return;
                }

                // If all validations pass, save the event to Firestore
                saveEventToFirestore(
                  eventNameController.text,
                  eventDesController.text,
                  selectedDate!,
                  startTimeController.text,
                  endTimeController.text, 
                  numberOfPeople,
                  locationController.text,
                );
                Navigator.of(context).pop();
              } catch (e) {
                // Catch parsing errors and show an appropriate message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Invalid time format. Please use HH:mm a format!')),
                );
              }
            },
            child: const Text("Add Event",
            style: TextStyle(color: Color.fromARGB(255, 70, 58, 36)),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel",
             style: TextStyle(color: Color.fromARGB(255, 70, 58, 36))
             ,),
          ),
        ],
      );
    },
  );
}



  // Save event to Firestore
  void saveEventToFirestore(String eventName, String eventDes, DateTime eventDate, String startTime, String endTime, int numberOfPeople, String eventLocation) {
  final eventCollection = FirebaseFirestore.instance
  .collection('volunteer')
  .doc(eventName);
  
  eventCollection.set({
    'eventName': eventName,
    'eventDes': eventDes,
    'eventDate': eventDate,
    'startTime': startTime,
    'endTime': endTime, 
    'numberOfPeople': numberOfPeople,
    'eventLocation': eventLocation,
  }).then((value) {
    print('Event added to Firestore');
  }).catchError((error) {
    print('Failed to add event: $error');
  });
}

// Delete event from Firestore 
void deleteTask(String eventName) {
  // Get the event name from the event at the given index
  print("Attempting to delete event: $eventName");

  // Delete the event from Firestore
  FirebaseFirestore.instance.collection('volunteer').doc(eventName).delete().then((_) {
    print('Event "$eventName" deleted from Firestore');
  }).catchError((error) {
    print('Failed to delete event from Firestore: $error');
  });
}
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("V O L U N T E E R"),
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
      floatingActionButton: FloatingActionButton(
        onPressed: createNewVolunteerEvent,
        backgroundColor: Color.fromARGB(255, 238, 227, 196),
        child: Icon(Icons.add, color: Colors.black,),
      ),
      drawer: const MyDrawer(),
      body: 
          Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                .collection('volunteer')
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
                      return VolunteerEventTile(
                        eventName: event['eventName'],
                        eventDes: event['eventDes'],
                        eventDate: DateFormat('dd/MM/yyyy').format(event['eventDate'].toDate()),
                        startTime: event['startTime'],
                        endTime: event['endTime'],
                        numberOfPeople: event['numberOfPeople'],
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