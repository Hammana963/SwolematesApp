import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetFirstName extends StatefulWidget {
  const GetFirstName({Key? key}) : super(key: key);

  @override
  State<GetFirstName> createState() => _GetFirstNameState();
}

class _GetFirstNameState extends State<GetFirstName> {
  FirebaseFirestore db = FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {
    final city = <String, String>{
      "name": "Los Angeles",
      "state": "CA",
      "country": "USA"
    };

    db
        .collection("cities")
        .doc("LA")
        .set(city)
        .onError((e, _) => print("Error writing document: $e"));
    final docData = {
      "stringExample": "Hello world!",
      "booleanExample": true,
      "numberExample": 3.14159265,
      "dateExample": Timestamp.now(),
      "listExample": [1, 2, 3],
      "nullExample": null
    };

    final nestedData = {
      "a": 5,
      "b": true,
    };

    docData["objectExample"] = nestedData;

    db
        .collection("data")
        .doc("one")
        .set(docData)
        .onError((e, _) => print("Error writing document: $e"));

    return const Placeholder();
  }
}
