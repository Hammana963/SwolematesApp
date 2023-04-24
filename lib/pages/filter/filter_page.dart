import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swolematesflutterapp/components/filter_button.dart';
import 'package:swolematesflutterapp/components/my_button.dart';

import '../matches/matches_page.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  List<bool> buttonSelected = []; //true if selected
  final buttonCount = 3;
  late FirebaseFirestore db;
  late User user;

  @override
  void initState() {
    db = FirebaseFirestore.instance;
    user = FirebaseAuth.instance.currentUser!;
    super.initState();
    for (int i = 0; i < buttonCount; i++) {
      buttonSelected.add(false);
    }
  }

  void selectButton(int index) {
    setState(() {
      buttonSelected[index] = !(buttonSelected[index]);
      print(buttonSelected);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Text(
                    "Choose your",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Workout goals",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    "It will help us find",
                    style: TextStyle(fontSize: 20),
                  ),
                  const Text(
                    "the right partner for you",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 90,
                  ),
                  const Text(
                    "Select up to 3",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 50),
                  SizedBox(
                    height: 250,
                    width: 200,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: buttonCount,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: FilterButton(
                            selected: buttonSelected[index],
                            function: () {
                              selectButton(index);
                            },
                            index: index,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 100),
          Visibility(
              visible: buttonSelected.contains(true),
              child: MyButton( //need TO UPLOAD BUTTON STATUS
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/home', (route) => false);
                },
                text: "Confirm",
                color: const Color(0xFF05861A),
              ))
        ],
      )),
    );
  }
}
