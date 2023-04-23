import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swolematesflutterapp/pages/calendar_page.dart';
import 'package:swolematesflutterapp/pages/login_page.dart';
import 'package:swolematesflutterapp/pages/register_page.dart';
import 'home_page.dart';
import 'profile_pic_page.dart';
import 'login_or_register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          // listens to auth state changes
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              User user = FirebaseAuth.instance.currentUser!;
              Future<bool> userProfileIsComplete() async {


                try {
                  final userDocRef = FirebaseFirestore.instance.collection('users').doc(user.email);
                  final docSnapshot = await userDocRef.get();


                  if (docSnapshot.exists) {
                    final data = docSnapshot.data();
                    return data!.containsKey('profilePic') && data.containsKey('gym');
                  } else {
                    return false;
                  }
                } catch (error) {
                  return false;
                }
              }
              return FutureBuilder(
                  future: userProfileIsComplete(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data! == true) {
                        // Profile is complete, navigate to home page
                        return HomePage();
                      }
                      else {
                        // Profile is not complete, navigate to profile creation page
                        return ProfilePicPage();
                      }
                    }
                    return CircularProgressIndicator();
                  });
            }
            else {
              return LoginOrRegisterPage();
            }
          }
          ),
    );
  }
}
