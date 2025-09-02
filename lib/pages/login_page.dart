//import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/auth/auth_service.dart';
import 'package:flutter_application_1/componants/square_tile.dart';
import 'package:flutter_application_1/helper/helper_functions.dart';
import 'package:flutter_application_1/services/auth_service-Duplicatefile.dart';
import '../componants/my_button.dart';
import '../componants/my_textfield.dart';

class LoginPage extends StatefulWidget {
  
  final void Function()? onTap;
   
  const LoginPage({ super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
// text controllers
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  // login method
  void login() async {
    // show loading circle
    showDialog(
      context: context,
       builder: (context) => const Center
        (child: CircularProgressIndicator(),
       )
    );
    // try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
         password: passwordController.text
         );
         //displayMessageToUser(const Text("helloo") as String, context);
         // pop loading circle
         if (context.mounted) Navigator.pop(context);
    }
      // display any errors
      on FirebaseAuthException catch (e) {
        // pop loading circle
        Navigator.pop(context);
        displayMessageToUser(e.code, context);
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
            const SizedBox(height: 35),
              // logo
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: SizedBox(
                height: 200,
                width: 200,
                  child: Image.asset(
                  'lib/images/logo.png',
                  fit: BoxFit.contain,
                ),
              )
              ),

              //const SizedBox(height: 5),
              // title
              const Text(
                'T H E  H I V E',
                style: TextStyle(
                  //fontWeight: FontWeight.bold,
                  fontSize: 50,
                ),
              ),
          
              const SizedBox(height: 35),

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

              // forgot password
              Padding(
                padding: const EdgeInsets.only(right:15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // sign in button
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: MyButton(
                  text: "Login",
                  onTap: login,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[700]),

                        ),
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
                
                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     SquareTile(
                        onTap: () => AuthService().signInWithGoogleFirebase(),
                        imagePath: 'lib/images/google.png',
                        ),
                  ],
                ),

                // don't have an account? register here
              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an Account?",
                    style: TextStyle(
                       color: Theme.of(context).colorScheme.secondary,
                    ),),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      " Register here",
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