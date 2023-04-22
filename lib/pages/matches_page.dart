import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'auth_page.dart';

class MatchesPage extends StatefulWidget {
  const MatchesPage({Key? key}) : super(key: key);

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  void signUserOut() {
    FirebaseAuth.instance.signOut();
    //clears navigation history (push and remove until)
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AuthPage()),
    );
    // Navigator.pushAndRemoveUntil(context,
    //     //transitions with no default animation
    //     PageRouteBuilder(
    //       pageBuilder: (context, animation1, animation2) => AuthPage(),
    //       transitionDuration: Duration.zero,
    //       reverseTransitionDuration: Duration.zero,
    //     ), (r) {
    //   return false;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(onPressed: signUserOut, icon: const Icon(Icons.logout))
        ],
      ),
      body: SafeArea(child: Center(child: Text("MATCHES"))),
    );
  }
}
