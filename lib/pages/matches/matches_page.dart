import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swolematesflutterapp/models/user.dart';

class MatchesPage extends StatefulWidget {
  const MatchesPage({Key? key}) : super(key: key);

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: 500,
                height: 500,
                child: Consumer<UserModel>(
                  builder: (context, userModel, _) {
                    return StreamBuilder<QuerySnapshot>(
                      stream: userModel.usersStream,
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {
                        if (snapshots.hasError) {
                          return const Center(child: Text('Something went wrong'));
                        }
                        if (snapshots.connectionState == ConnectionState.waiting) {
                          return const SizedBox.shrink();
                        }

                        return ListView.builder(
                            itemCount: snapshots.data!.docs.length,
                            itemBuilder: (context, index) {
                              var data = snapshots.data!.docs[index].data() as Map<String, dynamic>;
                              // print(data);
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
                    );
                  }

                ),
              ),
            ],
          ),
        ),

      ),

    );
  }
}
