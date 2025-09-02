import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/componants/my_drawer.dart';
import 'package:flutter_application_1/pages/Calender_Widgits/event_tiles.dart';
import 'package:flutter_application_1/pages/club/club_tile.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  User? currentUser = FirebaseAuth.instance.currentUser;

  Future<List<String>> getUserJoinedClubs() async {
    // Fetch documents from the 'joinedClubs' subcollection
    QuerySnapshot joinedClubsSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser!.email)
        .collection('joinedClubs') // Access the joinedClubs subcollection
        .get();

    // Extract the club names from the documents
    return joinedClubsSnapshot.docs.map((doc) => doc.id).toList();
  }

  Stream<List<QueryDocumentSnapshot>> getClubEvents(List<String> joinedClubs) {
    if (joinedClubs.isEmpty) {
      return Stream.value([]); // Return an empty list if no joined clubs
    }

    List<Stream<List<QueryDocumentSnapshot>>> clubEventStreams = joinedClubs.map((clubName) {
      return FirebaseFirestore.instance
          .collection('club') 
          .doc(clubName)
          .collection('clubEvents')
          .snapshots()
          .map((snapshot) => snapshot.docs);  // Convert QuerySnapshot to List<QueryDocumentSnapshot>
    }).toList();

    // Merge all event streams and flatten them
    return Rx.combineLatestList(clubEventStreams)
        .map((listOfLists) => listOfLists.expand((events) => events).toList())
        .handleError((error) {
          print("Error fetching events: $error");
          return []; // Return empty list on error
        });
  }

  Stream<List<QueryDocumentSnapshot>> getVolunteerEvents() {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser!.email)
        .collection('myVolunteerEvents') // Access the volunteer events collection
        .snapshots()
        .map((snapshot) => snapshot.docs);  // Convert QuerySnapshot to List<QueryDocumentSnapshot>
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("M Y  C A L E N D A R"),
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
      drawer: const MyDrawer(),
      body: FutureBuilder<List<String>>(
        future: getUserJoinedClubs(),
        builder: (context, clubSnapshot) {
          if (clubSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (clubSnapshot.hasError) {
            return const Center(child: Text('Error fetching clubs!'));
          }
          if (clubSnapshot.data == null || clubSnapshot.data!.isEmpty) {
            return const Center(child: Text('No clubs joined yet...'));
          }

          List<String> joinedClubs = clubSnapshot.data!;

          return StreamBuilder<List<QueryDocumentSnapshot>>(
            stream: Rx.combineLatest2(
              getClubEvents(joinedClubs),  // Fetch club events
              getVolunteerEvents(),        // Fetch volunteer events
              (clubEvents, volunteerEvents) {
                // Merge the two event lists
                return [...clubEvents, ...volunteerEvents];
              },
            ),
            builder: (context, eventSnapshot) {
              if (eventSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (eventSnapshot.hasError) {
                return const Center(child: Text('Error fetching events!'));
              }
              if (eventSnapshot.data == null || eventSnapshot.data!.isEmpty) {
                return const Center(child: Text('No upcoming events.'));
              }

              var events = eventSnapshot.data!;

              // Sort events by eventDate and eventTime
              events.sort((a, b) {
                var aData = a.data() as Map<String, dynamic>;
                var bData = b.data() as Map<String, dynamic>;

                DateTime aDateTime = aData['eventDate'].toDate();
                DateTime bDateTime = bData['eventDate'].toDate();

                // If dates are the same, compare times
                if (aDateTime.isAtSameMomentAs(bDateTime)) {
                  return aData['eventTime'].compareTo(bData['eventTime']);
                }
                return aDateTime.compareTo(bDateTime);
              });

              return ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  var event = events[index].data() as Map<String, dynamic>;

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
          );
        },
      ),
    );
  }

  /// Deletes an event from Firestore
  void deleteTask(String eventId) {
    FirebaseFirestore.instance
        .collectionGroup('clubEvents') // Find event from any club
        .where(FieldPath.documentId, isEqualTo: eventId) // Match event ID
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        snapshot.docs.first.reference.delete().then((_) {
          print('Event "$eventId" deleted from Firestore');
        }).catchError((error) {
          print('Failed to delete event: $error');
        });
      }
    });
  }
}
