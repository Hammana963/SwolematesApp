import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swolematesflutterapp/components/my_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;
  var imageFileName = "";


  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

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
  print("${file?.path}");
  if (file == null) return;
  final storageRef = FirebaseStorage.instance.ref();
  String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
  imageFileName = uniqueFileName;

  // Upload file and metadata to the path 'images/mountains.jpg'
  try {
  // final uploadTask = storageRef.child("images");
  // final uploadedImageRef = uploadTask.child(uniqueFileName);
  // uploadedImageRef.putFile(File(file.path));
  final uploadTask = storageRef
      .child("images/$uniqueFileName")
      .putFile(File(file.path));

  uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
  switch (taskSnapshot.state) {
  case TaskState.running:
  final progress =
  100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
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
  // ...
  break;
  }
  });

  } catch(error) {
  // Upload error;

  }
  }catch (e) {
  print(e);
  // image picker error display wrong FILE TYPE MESSAGE
  }

}

Future<Image?> downloadImage() async {
  final storageRef = FirebaseStorage.instance.ref();

  try {
    final imageRef = storageRef.child("images/$imageFileName");;
    const oneMegabyte = 1024 * 1024;
    final Uint8List? data = await imageRef.getData(oneMegabyte);
    return Image.memory(data!);
  } on FirebaseException catch (e) {
    // Handle any errors.
  }
}




  // Future<String> getUserName() async{
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
            (child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 25),

                FutureBuilder(
                  future: getFirstName(),
                    builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            "Welcome, ${snapshot.data!}",
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                      return const CircularProgressIndicator();
                    }
                ),


                const SizedBox(height: 150),
                // FutureBuilder(
                //     future: downloadImage(),
                //     builder: (context, snapshot) {
                //       if (snapshot.hasData) {
                //         return Image(
                //           image: null,
                //
                //         );
                //       }
                //       return const CircularProgressIndicator();
                //     }
                // ),
                const SizedBox(height: 100,),

                MyButton(onTap: () => uploadImage(), text: "Add a photo"),

                const SizedBox(height: 25),

                Text(
                  "Logged in as: ${user.email!}",
                style: const TextStyle(
                  fontSize: 20,
                ),
                ),

              ],
            ),
          )
      ),
    );
  }
}
