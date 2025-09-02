import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;

class EventDetailScreen extends StatelessWidget {
  final calendar.Event event;

  EventDetailScreen({required this.event});

  @override
  Widget build(BuildContext context) {
    final start = event.start?.dateTime?.toLocal() ?? DateTime.now();
    final end = event.end?.dateTime?.toLocal() ?? DateTime.now();
    return Scaffold(
      appBar: AppBar(title: Text(event.summary ?? 'Event Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Title: ${event.summary ?? 'No Title'}", style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text("Start Time: ${start.toString()}", style: TextStyle(fontSize: 16)),
            Text("End Time: ${end.toString()}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            event.location != null
                ? Text("Location: ${event.location}", style: TextStyle(fontSize: 16))
                : Container(),
            SizedBox(height: 10),
            event.description != null
                ? Text("Description: ${event.description}", style: TextStyle(fontSize: 16))
                : Container(),
          ],
        ),
      ),
    );
  }
}
