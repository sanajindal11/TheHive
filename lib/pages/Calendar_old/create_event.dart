import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/auth_service.dart';
import 'package:flutter_application_1/auth/calender_service.dart';

class CreateEvent extends StatefulWidget {
  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final AuthService authService = AuthService();
  final CalendarService calendarService = CalendarService();
  final _formKey = GlobalKey<FormState>();

  String eventTitle = '';
  String eventDescription = '';
  DateTime? startDate;
  DateTime? endDate;

  Future<void> addEvent() async {
   String? accessToken = await authService.signInWithGoogleCloud();
    if (accessToken != null)  {
      try {
        await calendarService.createEvent(
          accessToken,
          eventTitle,
          eventDescription,
          startDate!,
          endDate!,
        );
        print("Event added successfully");
        Navigator.pop(context); // Go back to the previous screen
      } catch (e) {
        print("❌ Error creating event: $e");
      }
    } else {
      print("❌ Failed to retrieve access token");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Event Title'),
                onChanged: (value) {
                  setState(() {
                    eventTitle = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an event title';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Event Description'),
                onChanged: (value) {
                  setState(() {
                    eventDescription = value;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    if (startDate != null && endDate != null) {
                      await addEvent();
                    } else {
                      print('❌ Please select both start and end dates');
                    }
                  }
                },
                child: Text('Create Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}