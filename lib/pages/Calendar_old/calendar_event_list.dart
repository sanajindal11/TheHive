import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/Calendar_old/event_detail_screen.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;

class CalendarEventList extends StatelessWidget {
  final List<calendar.Event> events;

  CalendarEventList({required this.events});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        final start = event.start?.dateTime ?? event.start?.date;
        final startTime = start?.toLocal().toString() ?? 'No Start Time';

        return Card(
          margin: EdgeInsets.all(10),
          child: ListTile(
            contentPadding: EdgeInsets.all(15),
            title: Text(event.summary ?? 'No Title', style: TextStyle(fontSize: 18)),
            subtitle: Text('Starts at: $startTime', style: TextStyle(fontSize: 14)),
            trailing: event.location != null ? Icon(Icons.location_on) : null,
            onTap: () {
              // Optionally, navigate to event details screen
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventDetailScreen(event: event),
    ),
  );
              
            },
          ),
        );
      },
    );
  }
}
