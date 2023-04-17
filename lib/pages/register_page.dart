import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:swolematesflutterapp/components/google_sign_in_button.dart';
import 'package:swolematesflutterapp/components/my_button.dart';
import 'package:swolematesflutterapp/components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  var signInStatus = "";

  void signUserIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    // try signing in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' ||
          e.code == 'wrong-password' ||
          e.code == 'invalid-email') {
        //show error to user
        wrongSignInMessage();
      }
    }
    finally {
      Navigator.pop(context);
    }

  }

  void wrongSignInMessage() {
    setState(() {
      signInStatus = "Wrong email or password";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.fitness_center_rounded,
                    size: 70,
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    "Create an Account",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // const Text(
                  //   "Sign In",
                  //   style: TextStyle(
                  //     fontSize: 20,
                  //   ),
                  // ),
                  const SizedBox(height: 20),
                  // const SizedBox(height: 20),

                  // Text(
                  //   signInStatus,
                  //   style: const TextStyle(
                  //     fontSize: 15,
                  //     color: Colors.red,
                  //   ),
                  // ),


                  MyTextField(
                    controller: firstNameController,
                    hintText: "First Name",
                    obscureText: false,
                    prefixIcon: const Icon(
                      Icons.person,
                      size: 24.0,
                      semanticLabel: 'profile icon',
                    ),
                  ),

                  const SizedBox(height: 10),

                  MyTextField(
                    controller: lastNameController,
                    hintText: "Last Name",
                    obscureText: false,
                    prefixIcon: const Icon(
                      Icons.person,
                      size: 24.0,
                      semanticLabel: 'profile icon',
                    ),
                  ),

                  const SizedBox(height: 10),

                  MyTextField(
                    controller: emailController,
                    hintText: "Email",
                    obscureText: false,
                    prefixIcon: const Icon(
                      Icons.mail,
                      size: 24.0,
                      semanticLabel: 'email icon',
                    ),
                  ),

                  const SizedBox(height: 10),

                  MyTextField(
                    controller: passwordController,
                    hintText: "Password",
                    obscureText: true,
                    prefixIcon: const Icon(
                      Icons.lock,
                      size: 24.0,
                      semanticLabel: 'password icon',
                    ),
                  ),



                  const SizedBox(height: 10),

                  MyButton(
                    onTap: signUserIn,
                    text: "Register",
                  ),

                  const SizedBox(height: 50),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Colors.grey[400],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            "Or",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700]
                            ),
                          ),
                        ),

                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 50),

                  const GoogleSignInButton(),

                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        " Sign in",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
