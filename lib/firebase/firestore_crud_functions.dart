import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FireStoreFunctions extends StatefulWidget {
  const FireStoreFunctions({Key? key}) : super(key: key);

  @override
  State<FireStoreFunctions> createState() => _FireStoreFunctionsState();
}

class _FireStoreFunctionsState extends State<FireStoreFunctions> {void uploadImage() async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  var imageFileName = "";
  bool picSelected = false;
  late String profileFilePath;
  final user = FirebaseAuth.instance.currentUser!;

void uploadImage() async {
    ImagePicker imagePicker = ImagePicker();
    try {
      XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
      print("${file?.path}");
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
              print("Upload is $progress% complete.");
              break;
            case TaskState.paused:
              print("Upload is paused.");
              break;
            case TaskState.canceled:
              print("Upload was canceled");
              break;
            case TaskState.error:
              // Handle unsuccessful uploads
              break;
            case TaskState.success:
              // Handle successful uploads on complete
              final data = {"profilePic": imageFileName};
              final docRef = db.collection("users").doc(user.email);
              final doc = await docRef.set(data, SetOptions(merge: true));
              // print(getImage());
              // final data = doc.data() as Map<String, dynamic>;
              // print(data["first"]);
              break;
          }
        });
      } catch (error) {
        // Upload error;
      }
    } catch (e) {
      print(e);
      // image picker error display wrong FILE TYPE MESSAGE
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
