// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:swolematesflutterapp/pages/auth_page.dart';
import 'package:swolematesflutterapp/pages/calendar_page.dart';
import 'package:swolematesflutterapp/pages/filter_page.dart';
import 'package:swolematesflutterapp/pages/get_first_name.dart';
import 'package:swolematesflutterapp/pages/home_page.dart';
import 'package:swolematesflutterapp/pages/profile_pic_page.dart';
import 'package:swolematesflutterapp/pages/matches_page.dart';
import 'package:swolematesflutterapp/pages/places_page.dart';
import 'package:swolematesflutterapp/pages/register_page.dart';
import 'pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase/firebase_options.dart';
import 'components/calendar_box.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    // name: 'name-here',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const SwolematesApp());
}

class SwolematesApp extends StatelessWidget {
  const SwolematesApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const AuthPage(),
        '/profilePic': (context) => const ProfilePicPage(),
        '/places': (context) => const PlacesPage(),
        '/filter': (context) => const FilterPage(),
        '/matches': (context) => const MatchesPage(),
        '/home': (context) => const HomePage(),
      },
      // home: AuthPage(),
      debugShowCheckedModeBanner: false,
      // TODO: Add a theme (103)
    );
  }
}
