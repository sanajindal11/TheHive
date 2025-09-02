import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/login_or_register.dart';
import 'package:flutter_application_1/pages/side_bar_page.dart';
//import 'package:googleapis/calendar/v3.dart';
//import 'package:googleapis/servicecontrol/v2.dart';
//import 'package:googleapis_auth/auth_io.dart';
//import 'package:url_launcher/url_launcher.dart';

/*final _clientID = ClientId('1090643386575-p6r442vl76k9hqqq6jffo8q7boh8341b.apps.googleusercontent.com', '');
final _scopes = [CalendarApi.calendarScope];

Future<AuthClient> getAuthClient() async {
  final completer = Completer<AuthClient>();
  await clientViaUserConsent(_clientID, _scopes, (url) {
    launch(url);
  }).then((client) {
    completer.complete(client);
  }).catchError((error) {
    completer.completeError(error);
  });
  return completer.future;
}
*/
class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user IS logged in
          if (snapshot.hasData) {
            return const SideBarPage();
          }
          // user is NOT logged in
          else {
            return const LoginOrRegister();
          }
        }
    ),
    );
  }
}