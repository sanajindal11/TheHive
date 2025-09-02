import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/auth_service.dart';
import 'package:flutter_application_1/pages/calendar_page.dart';


class LoginScreen extends StatelessWidget {
  final AuthService authService = AuthService();

  void _signIn(BuildContext context) async {
    String? accessToken = await authService.signInWithGoogleFirebase();
    if (accessToken != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CalendarPage()),
      );
    } else {
      print("❌ Google Sign-In Failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _signIn(context),
          child: Text("Sign in with Google"),
        ),
      ),
    );
  }
}
