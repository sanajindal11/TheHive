import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/auth_service.dart';
import 'package:flutter_application_1/pages/choose_school.dart';
import '../componants/my_button.dart';
import '../componants/my_textfield.dart';
import '../componants/square_tile.dart';
import '../helper/helper_functions.dart';
import '../services/auth_service-Duplicatefile.dart';

class RegisterPage extends StatefulWidget {

final void Function()? onTap;

const RegisterPage({
  super.key,
  required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
 // text controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPwController = TextEditingController();

  // register method
  void registerUser () async {
    // show loading circle
    showDialog(
      context: context,
       builder: (context) => const Center(
        child: CircularProgressIndicator(),
       ),
      );
    
    // make sure passwords match
    if (passwordController.text != confirmPwController.text) {
      // pop loading circle
      Navigator.pop(context);

      // show error message
      displayMessageToUser("Passwords don't match!", context);
    }
    // if passwords match 
    else {
        // try creating the user
        try {
        // create the user
        UserCredential? userCredential = 
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, 
          password: passwordController.text,
        );

        // create a user document and add to firestore
        createUserDocument(userCredential);

        // pop loading circle
        if (context.mounted) Navigator.pop(context);
        } on FirebaseAuthException catch (e) {
        // pop loading circle
        Navigator.pop(context);

        // display message to user
        displayMessageToUser(e.code, context);
      }

      // go to choose school page
       Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ChooseSchoolPage()),
      );
    }
  }

  // create a user document and collect them in a firestore
 Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
      .collection("Users")
      .doc(userCredential.user!.email)
      .set({
        'email': userCredential.user!.email,
        'username': usernameController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
           children: [
              // logo
              /* Padding(
                padding: const EdgeInsets.all(25.0),
                child: Image.asset(
                  'lib/images/ttpd.png'
                ),
              ),*/

              const SizedBox(height: 16),
              // logo
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: SizedBox(
                height: 170,
                width: 170,
                  child: Image.asset(
                  'lib/images/logo.png',
                  fit: BoxFit.contain,
                ),
              )
              ),
              const SizedBox(height: 2), 

              // title
              const Text(
                'T H E  H I V E',
                style: TextStyle(
                  //fontWeight: FontWeight.bold,
                  fontSize: 50,
                ),
              ),
          
              const SizedBox(height: 25),

              // username textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: MyTextField(
                  hintText: "Name",
                  obscureText: false,
                  controller: usernameController,
                  ),
              ),

              const SizedBox(height: 10),

              // email textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: MyTextField(
                  hintText: "Email",
                  obscureText: false,
                  controller: emailController,
                  ),
              ),

              const SizedBox(height: 10), 

              // password text field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: MyTextField(
                  hintText: "Password",
                  obscureText: true,
                  controller: passwordController,
                  ),
                ),

                const SizedBox(height: 10),

                // confirm password text field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: MyTextField(
                  hintText: "Confirm Password",
                  obscureText: true,
                  controller: confirmPwController,
                  ),
                ),

                const SizedBox(height: 10),

              // register button
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: MyButton(
                  text: "Register",
                  onTap: registerUser,
                  ),
              ),

              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      )
                    ),
                  
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                        )
                    )
                  ],
                ),
                ),
                
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an Account?",
                    style: TextStyle(
                       color: Theme.of(context).colorScheme.secondary,
                    ),),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      " Login here",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                  ),
                ],
              ),
           ]

        ),
        ),
    );
  }
}