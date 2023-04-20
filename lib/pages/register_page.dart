import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:swolematesflutterapp/components/google_sign_in_button.dart';
import 'package:swolematesflutterapp/components/my_button.dart';
import 'package:swolematesflutterapp/components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref();

  var signInStatus = "";


  void signUserUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    if (!passwordConfirmed()) {
      Navigator.pop(context);
      wrongSignInMessage("Passwords don't match");
      return;
    }

    // try signing in
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );
      addUserDetails();
    } on FirebaseAuthException catch (e) {

        wrongSignInMessage(e.message);
    }
    finally {
      Navigator.pop(context);
    }

  }

  void addUserDetails() {
    final user = <String, dynamic>{
      "first": capitalizeFirstLetter(firstNameController.text.trim()),
      "last": capitalizeFirstLetter(lastNameController.text.trim()),
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
    };

    db
        .collection("users")
        .doc(user["email"])
        .set(user);
    ;//.then((DocumentReference doc) =>
        // print('DocumentSnapshot added with ID: ${doc.id}'));
  }

  void wrongSignInMessage(eMessage) {
    setState(() {
      signInStatus = eMessage;
    });

  }
  bool passwordConfirmed() {
    if (passwordController.text.trim() == confirmPasswordController.text.trim() ? true : false) {
      return true;
    } else {
      return false;
    }
  }

  String capitalizeFirstLetter(String str) {
    return "${str[0].toUpperCase()}${str.substring(1).toLowerCase()}";
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.fitness_center_rounded,
                    size: 100,
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
                  const SizedBox(height: 30),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text(
                      signInStatus,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.red,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),


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

                  MyTextField(
                    controller: confirmPasswordController,
                    hintText: "Confirm Password",
                    obscureText: true,
                    prefixIcon: const Icon(
                      Icons.lock,
                      size: 24.0,
                      semanticLabel: 'password icon',
                    ),
                  ),



                  const SizedBox(height: 10),

                  MyButton(
                    onTap: signUserUp,
                    text: "Register",
                    color: Colors.black,
                  ),

                  // const SizedBox(height: 50),

                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         child: Divider(
                  //           thickness: 1,
                  //           color: Colors.grey[400],
                  //         ),
                  //       ),
                  //
                  //       Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  //         child: Text(
                  //           "Or",
                  //           style: TextStyle(
                  //               fontSize: 16,
                  //               color: Colors.grey[700]
                  //           ),
                  //         ),
                  //       ),
                  //
                  //       Expanded(
                  //         child: Divider(
                  //           thickness: 1,
                  //           color: Colors.grey[400],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  // const SizedBox(height: 50),
                  //

                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          " Sign in",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
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
