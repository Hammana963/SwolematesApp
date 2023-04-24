import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swolematesflutterapp/models/user.dart';
import 'package:swolematesflutterapp/pages/auth/auth_page.dart';
import 'package:swolematesflutterapp/pages/filter/filter_page.dart';
import 'package:swolematesflutterapp/pages/home_page.dart';
import 'package:swolematesflutterapp/pages/profile/profile_pic_page.dart';
import 'package:swolematesflutterapp/pages/matches/matches_page.dart';
import 'package:swolematesflutterapp/pages/places/places_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:swolematesflutterapp/pages/profile/settings_page.dart';
import 'firebase/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const SwolematesApp());
}

class SwolematesApp extends StatelessWidget {
  const SwolematesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => UserModel(),
        ),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the AuthPage widget.
          '/': (context) => const AuthPage(),
          '/profilePic': (context) => const ProfilePicPage(),
          '/places': (context) => const PlacesPage(),
          '/filter': (context) => const FilterPage(),
          '/matches': (context) => const MatchesPage(),
          '/home': (context) => const HomePage(),
          '/settings': (context) => const SettingsPage(),
        },
        debugShowCheckedModeBanner: false,

      ),
    );
  }
}
