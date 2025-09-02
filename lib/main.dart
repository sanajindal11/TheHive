import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/auth/auth.dart';
import 'package:flutter_application_1/auth/calender_service.dart';
import 'package:flutter_application_1/pages/calendar_page.dart';
import 'package:flutter_application_1/pages/choose_school.dart';
import 'package:flutter_application_1/pages/club/club_outline.dart';
import 'package:flutter_application_1/pages/club/club_home_page.dart';
import 'package:flutter_application_1/pages/help_page.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/profile_page.dart';
import 'package:flutter_application_1/pages/search_page.dart';
import 'package:flutter_application_1/pages/create_a_club.dart';
import 'package:flutter_application_1/pages/users_page.dart';
import 'package:flutter_application_1/pages/volunteer_page.dart';
import 'package:googleapis/calendar/v3.dart';
import 'auth/login_or_register.dart';
import 'firebase_options.dart';
import 'pages/theme/dark_mode.dart';
import 'pages/theme/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      theme:lightMode,
      darkTheme: darkMode,
      //home: IntroPage()
      routes: {
        '/login_or_register_page': (context) => const LoginOrRegister(),
        '/calendar_page': (context) => CalendarPage(),
        '/home_page': (context) => const HomePage(),
        '/profile_page': (context) => ProfilePage(),
        '/search_page': (context) => const SearchPage(),
        '/users_page': (context) => const UsersPage(),
        //'/demo_club': (context) => const ClubHomePage(),
        //'/club_outline': (context) => const ClubOutline(),
        '/create_a_club': (context) => const CreateAClub(),
        '/choose_school': (context) => ChooseSchoolPage(),
        '/help_page': (context) => HelpPage(),
        '/volunteer_page':(context) => VolunteerPage(),
      },
    );
  }
}

