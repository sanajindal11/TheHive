import 'dart:convert';
import 'package:flutter_application_1/auth/auth_service.dart';
import 'package:flutter_application_1/services/auth_service-Duplicatefile.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis/calendar/v3.dart' as calendar;
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';


/*
  This class is responsible for fetching events from the Google Calendar API.
  It uses the Google Calendar API to fetch events from a specific calendar.
  The `getCalendarEvents` method returns a list of events from the calendar.
*/
const List<String> _scopes = [
      'https://www.googleapis.com/auth/calendar', // Full access (create, edit, delete events)
      // 'https://www.googleapis.com/auth/calendar.readonly' // Read-only access (if needed)
    ];

class CalendarService {
  final _clientID = ClientId('1090643386575-j7rsh60pqtr4ufq3t2j7vi5cprqbqn83.apps.googleusercontent.com', '');
  //final _scopes = [calendar.CalendarApi.calendarScope];
  
  //get timeZones => null;

  Future<List<dynamic>> getCalendarEvents(String accessToken) async {
    final Uri url = Uri.parse(
        'https://www.googleapis.com/calendar/v3/calendars/5dafe66382306e0f5002bec89daad7b41b9cf0ea394544d8b377e2c72468ecfa@group.calendar.google.com/events');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['items'] ?? [];  // ✅ Return list of events
    } 
    else {
      print("❌ Error fetching events: ${response.body}");
      return [];
    }
  }
  
  Future<void> createEvent(
    String accessToken,
    String title,
    String description,
    DateTime start,
    DateTime end,
  ) 
  async {
    final AuthClient authClient = await AuthService().getAuthenticatedClient();
    /*authenticatedClient(
      Client(),
      AccessCredentials(
        AccessToken('Bearer', accessToken, DateTime.now().toUtc().add(Duration(hours: 1))),
        null,
        _scopes,
      ),
    );*/

    final calendarApi = calendar.CalendarApi(authClient);

    try {
      final event = calendar.Event(
        summary: title,
        description: description,
        start: calendar.EventDateTime(
          dateTime: start,
          timeZone: 'UTC',
        ),
        end: calendar.EventDateTime(
          dateTime: end,
          timeZone: 'UTC',
        ),
      );

      await calendarApi.events.insert(event, '5dafe66382306e0f5002bec89daad7b41b9cf0ea394544d8b377e2c72468ecfa@group.calendar.google.com'); // 'primary' for default calendar
      print("Event Created!");
    } catch (e) {
      print("Error creating event: ${e.toString()}");
    }
  }
  
}





