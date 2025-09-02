import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/auth_service.dart';
import 'package:flutter_application_1/auth/calender_service.dart';
import 'package:flutter_application_1/pages/Calendar_old/create_event.dart';
import 'package:google_sign_in/google_sign_in.dart';
import "package:googleapis_auth/auth_io.dart";
import 'package:googleapis/calendar/v3.dart' as calendar;

class CalendarPageOld extends StatefulWidget {
  @override
  _CalendarPageOldState createState() => _CalendarPageOldState();
}

class _CalendarPageOldState extends State<CalendarPageOld> {
  final AuthService authService = AuthService();
  final CalendarService calendarService = CalendarService();
  List<dynamic> events = [];

  @override
  void initState() {
    super.initState();
    fetchCalendarEvents(); // Call method to fetch events
  }

  Future<void> fetchCalendarEvents() async {
    String? accessToken = await authService.signInWithGoogleCloud();
    if (accessToken != null) {
      try {
        List<dynamic> calendarEvents =
            await calendarService.getCalendarEvents(accessToken);
        setState(() {
          events = calendarEvents;
        });
      } catch (e) {
        print("❌ Error fetching events: $e");
      }
    } else {
      print("❌ Failed to retrieve access token");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Calendar Events'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: fetchCalendarEvents, // Refresh events when button is pressed
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: events.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(events[index]['summary'] ?? 'No Title'),
                        subtitle: Text(events[index]['start']?['dateTime'] ?? 'No Start Time'),
                      );
                    },
                  ),
          ),

          // Add Event Button
         Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // Navigate to the AddEventPage when the button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => (CreateEvent())),
                );
                // Add your button action here
                print("Button pressed");
              },
              child: Text('Add Event', style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}