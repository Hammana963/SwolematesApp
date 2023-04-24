import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserModel extends ChangeNotifier {
  String? _firstName;
  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('users').snapshots();
  final user = FirebaseAuth.instance.currentUser!;



  Future<String?> getFirstName() async {
    if (_firstName != null) {  //check if value is cached
      return _firstName;
    }
    final docRef = FirebaseFirestore.instance.collection("users").doc(user.email);
    final doc = await docRef.get();
    final data = doc.data() as Map<String, dynamic>;
    _firstName = data["first"]; //cache the data
    notifyListeners();
    return _firstName;

  }
  void signUserOut() {
    FirebaseAuth.instance.signOut();
    notifyListeners();
  }

  Future<CachedNetworkImageProvider> getImage() async {
    final docRef = FirebaseFirestore.instance.collection('users').doc(user.email);
    final doc = await docRef.get();
    final data = doc.data() as Map<String, dynamic>;
    return CachedNetworkImageProvider(data["profilePic"]);
  }

  String? get firstName => _firstName; //return value to check if cached or null
  Stream<QuerySnapshot> get usersStream => FirebaseFirestore.instance.collection('users').snapshots();



}

