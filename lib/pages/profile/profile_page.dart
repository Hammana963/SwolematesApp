import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:swolematesflutterapp/components/my_button.dart';
import 'package:swolematesflutterapp/pages/calendar/calendar_page.dart';
import 'package:swolematesflutterapp/pages/places/places_page.dart';

import '../../models/user.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();

}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }
  String? _firstName; // cached value
  FirebaseFirestore db = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;
  var imageFileName = "";
  late String profileFilePath;
  bool picSelected = false;

  Future<String> getFirstName() async {
    final docRef = db.collection("users").doc(user.email);
    final doc = await docRef.get();
    final data = doc.data() as Map<String, dynamic>;
    return (data["first"]);
  }

  void uploadImage() async {
    ImagePicker imagePicker = ImagePicker();
    try {
      XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
      // print("${file?.path}");
      if (file == null) return;
      profileFilePath = file.path;
      final storageRef = FirebaseStorage.instance.ref();
      String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
      setState(() {
        imageFileName = uniqueFileName;
        picSelected = true;
      });

      // Upload file and metadata to the path 'images/mountains.jpg'
      try {
        // final uploadTask = storageRef.child("images");
        // final uploadedImageRef = uploadTask.child(uniqueFileName);
        // uploadedImageRef.putFile(File(file.path));
        final uploadTask =
        storageRef.child("images/$uniqueFileName").putFile(File(file.path));

        uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
          switch (taskSnapshot.state) {
            case TaskState.running:
              final progress = 100.0 *
                  (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
              // print("Upload is $progress% complete.");
              break;
            case TaskState.paused:
            // print("Upload is paused.");
              break;
            case TaskState.canceled:
            // print("Upload was canceled");
              break;
            case TaskState.error:
            // Handle unsuccessful uploads
              break;
            case TaskState.success:
            // Handle successful uploads on complete
              var url = await (storageRef.child("images/$imageFileName").getDownloadURL());
              // print(url.toString());
              final data = {"profilePic": url.toString()};
              final docRef = db.collection("users").doc(user.email);
              final doc = await docRef.set(data, SetOptions(merge: true));
              break;
          }
        });
      } catch (error) {
        // Upload error;
      }
    } catch (e) {
      // print(e);
      // image picker error display wrong FILE TYPE MESSAGE
    }
  }

  // Future<String> getUserName() async{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(onPressed: () {
            Navigator.pushNamed(context, '/settings');
          }, icon: const Icon(Icons.settings))
        ],
      ),
      body: SafeArea(
          child: Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [

                const SizedBox(height: 200),

                Consumer<UserModel>(
                  builder: (context, userModel, _) {
                    return FutureBuilder(
                        future: userModel.getImage(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 90,
                              backgroundImage: snapshot.data,
                            );
                          }
                          return const CircularProgressIndicator();
                        });

                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                Consumer<UserModel>(
                  builder: (context, userModel, _) {
                    var cachedName = userModel.firstName;
                    if (cachedName != null) {
                      return Text(
                        cachedName,
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }
                    else {
                      return FutureBuilder(
                          future: userModel.getFirstName(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              _firstName = snapshot.data;
                              return Text(
                                snapshot.data!,
                                style: const TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }
                            return const CircularProgressIndicator();
                          });
                    }
                  },

                ),
                const SizedBox(height: 90),

                //visible once the picture is selected
                Visibility(
                    visible: picSelected,
                    child: MyButton(
                      onTap: () {
                        Navigator.pushNamed(context, '/places');
                      },
                      text: "Confirm",
                      color: const Color(0xFF05861A),
                    ))
              ],
            ),
          )),
    );
  }
}
