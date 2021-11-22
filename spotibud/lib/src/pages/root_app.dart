import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotibud/src/pages/top_page.dart';
import 'package:spotibud/src/pages/last_news_page.dart';
import 'package:spotibud/src/pages/user_page.dart';
import 'home_page.dart';
import 'last_news_page.dart';
import 'user_page.dart';

class RootApp extends StatefulWidget {
  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  bool loading = false;
  int index = 0;
  final pages = [
    UserPage(),
    HomePage(),
    SongsPage(),
    LastNewsPage(),
  ];
  int activeTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: GetPage(context),
    );
  }

  Widget GetPage(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 20.0,
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedItemColor: Colors.white,
        currentIndex: index,
        onTap: (int index) => setState(() => this.index = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: "User",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: "Artists",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.queue_music_rounded),
            label: "Songs",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.my_library_music_rounded), label: "News"),
        ],
      ),
    );
  }
}
