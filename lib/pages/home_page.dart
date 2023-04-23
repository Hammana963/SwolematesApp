import 'package:flutter/material.dart';
import 'widget_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 1;
  void navigateBottomBar(int index) {
    setState(() {
      selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
          onTap: navigateBottomBar,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "profile"),
            BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "home"),
            BottomNavigationBarItem(icon: Icon(Icons.chat_bubble), label: "chat"),

          ]
      ),
    );
  }
}
