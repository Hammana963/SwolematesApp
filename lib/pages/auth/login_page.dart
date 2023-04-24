import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swolematesflutterapp/components/google_sign_in_button.dart';
import 'package:swolematesflutterapp/components/my_button.dart';
import 'package:swolematesflutterapp/components/my_textfield.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;

  const LoginPage({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      //show error to user
      if (e.code == "user-not-found") {
        wrongSignInMessage("There is no user registered with this email.");
      } else {
        wrongSignInMessage(e.message);
      }
    } finally {
      Navigator.pop(context);
    }
  }

  void wrongSignInMessage(errorMessage) {
    setState(() {
      signInStatus = errorMessage;
    });
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
                  const SizedBox(height: 25),

                  const Text(
                    "Welcome Back",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      // color: Color(0xFF1DB22C),
                    ),
                  ),

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
                    text: "Log in",
                    color: Colors.black,
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
                                fontSize: 16, color: Colors.grey[700]),
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

                  // const SizedBox(height: 50),

                  // const GoogleSignInButton(),

                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // const Text(
                      //   "Not a member?",
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // GestureDetector(
                      //   onTap: widget.onTap,
                      //   child: const Text(
                      //     " Register now",
                      //     style: TextStyle(
                      //       color: Colors.blue,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  MyButton(
                    onTap: widget.onTap,
                    text: "Register",
                    color: Colors.black,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
