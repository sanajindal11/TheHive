import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ClubHomePage extends StatelessWidget {
  final String clubName;
  final String clubDescription;
  final String clubAdvisor;
  final String clubEmail;



  const ClubHomePage({
    super.key,
    required this.clubName,
    required this.clubDescription,  
    required this.clubAdvisor,
    required this.clubEmail,
    });

  Future<void> _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: clubEmail,
      queryParameters: {
        'subject': '$clubName Inquiry',
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $emailUri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 25),
              Text(
                "W E L C O M E  T O",
                textAlign: TextAlign.center, 
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${clubName.toUpperCase()}!",//"A R T  C L U B!",
                textAlign: TextAlign.center, 
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
               Text(
                clubDescription,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
          
              const SizedBox(height: 30),
          
               // Advisor
              Text(
                "Advisor: $clubAdvisor",
                style: const TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
              ),
          
              // Contact Us Section
              const Text(
                "Contact Us",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
          
              // Email Button
              ElevatedButton.icon(
                onPressed:() {},// _launchEmail,
                icon: const Icon(Icons.email, color:   Color(0xFF6D5B38),),
                label: Text("Email Us",style: TextStyle(color: Color(0xFF6D5B38)),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 250, 240, 213)
                ),
              ),   
            ],
          ),
        ),
      ),
    );
  }
}
