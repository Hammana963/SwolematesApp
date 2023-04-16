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
import 'package:swolematesflutterapp/calendar_screen.dart';
import 'login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'calendar_box.dart';

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
      home: CalendarPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        // scaffoldBackgroundColor: Colors.grey[300],
        appBarTheme: const AppBarTheme(elevation: 2),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
      ),
      // TODO: Add a theme (103)
    );
  }
}