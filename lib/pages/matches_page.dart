import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/my_button.dart';
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
    // Navigator.pop(context);
    // Navigator.pop(context);
    // Navigator.pop(context);
    //
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => const AuthPage()),
    // );
  }

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                width: 500,
                height: 500,
                child: StreamBuilder<QuerySnapshot>(
                  stream: _usersStream,
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {
                    if (snapshots.hasError) {
                      return const Text('Something went wrong');
                    }

                    if (snapshots.connectionState == ConnectionState.waiting) {
                      return const Text("Loading");
                    }

                    return ListView.builder(
                      itemCount: snapshots.data!.docs.length,
                        itemBuilder: (context, index) {
                      var data = snapshots.data!.docs[index].data() as Map<String, dynamic>;
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 25,
                          backgroundImage: NetworkImage(data['profilePic']),
                        ),
                        title: Text(
                          data['first'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    });
                  },
                ),
              ),
            ],
          ),
        ),

      ),

    );
  }
}
