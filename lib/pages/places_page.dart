import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_places_for_flutter/google_places_for_flutter.dart';
import 'package:swolematesflutterapp/config.dart';

import '../components/my_button.dart';
import 'filter_page.dart';
// AIzaSyA1rspwCiKgi8w53Usw1vnGkI03BLl8yVw

class PlacesPage extends StatefulWidget {
  const PlacesPage({Key? key}) : super(key: key);

  @override
  State<PlacesPage> createState() => _PlacesPageState();
}

class _PlacesPageState extends State<PlacesPage> {
  bool placeSelected = false;
  String apiKey = googleApiKey;
  late FirebaseFirestore db;
  late User user;
  late String placeId;

  @override
  void initState() {
    super.initState();
    db = FirebaseFirestore.instance;
    user = FirebaseAuth.instance.currentUser!;

  }

  void selectPlace(Place place) {
    setState(() {
      placeSelected = true;
    });
    placeId = place.placeId!;
  }

  Future<void> uploadPlace() async {
    // print('address ${place.description}');
      setState(() {
        placeSelected = true;
      });
    final data = {"gym": placeId};

    final docRef = db.collection("users").doc(user.email);
    final doc = await docRef.set(data, SetOptions(merge: true));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 30),
                const Text(
                  "Choose your Gym",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),

                const Text(
                  "Select from dropdown menu",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 250),

                const SizedBox(height: 10),
                SearchGooglePlacesWidget(
                  placeType: PlaceType.address, // PlaceType.cities, PlaceType.geocode, PlaceType.region etc
                  placeholder: 'Enter the address',
                  apiKey: apiKey,
                  onSearch: (Place place) {},
                  onSelected: (Place place) => selectPlace(place), //async {
                ),

                const SizedBox(height: 250),

                Visibility(
                    visible: placeSelected,
                    child: MyButton(
                      onTap: () {
                        uploadPlace();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const FilterPage()),
                        );
                      },
                      text: "Confirm",
                      color: const Color(0xFF05861A),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}