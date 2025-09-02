import 'package:googleapis/calendar/v3.dart';

class CalendarClient {
  // For storing the CalendarApi object, this can be used
  // for performing all the operations

  static CalendarApi? calendar;

  // For creating a new calendar event
  Future<Map<String, String>?> insert({
    required String title,
    required String description,
    required String location,
    required List<EventAttendee> attendeeEmailList,
    required bool shouldNotifyAttendees,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    Map<String, String>? eventData;

    String calendarId = "5dafe66382306e0f5002bec89daad7b41b9cf0ea394544d8b377e2c72468ecfa@group.calendar.google.com";
    Event event = Event();

    event.summary = title;
    event.description = description;
    event.attendees = attendeeEmailList;
    event.location = location;

    EventDateTime start = EventDateTime();
    start.dateTime = startTime;
    start.timeZone = "GMT+05:30";
    event.start = start;

    EventDateTime end = EventDateTime();
    end.timeZone = "GMT+05:30";
    end.dateTime = endTime;
    event.end = end;

    await calendar?.events.insert(event, calendarId, sendUpdates: shouldNotifyAttendees ? "all" : "none");

    return eventData;
  }
}