import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
        IconButton(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout)
        )
      ],),
      body: SafeArea(
          child: Center
            (child: Text(
              "Logged in as: ${user.email!}",
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          )
      ),
    );
  }
}
