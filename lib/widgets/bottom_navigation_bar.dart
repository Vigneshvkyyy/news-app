// ignore_for_file: library_private_types_in_public_api, unused_local_variable, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:task_project/widgets/saved_widget.dart';
import 'package:task_project/screens/discover_screen.dart';

import '../screens/profile_screen.dart.dart';
import 'news_carousel.dart';
import 'tab_bar.dart';

class BottomNavigationExample extends StatefulWidget {
  const BottomNavigationExample({Key? key}) : super(key: key);

  @override
  _BottomNavigationExampleState createState() =>
      _BottomNavigationExampleState();
}

class _BottomNavigationExampleState extends State {
  int _selectedTab = 0;

  final List _pages = [
     Home(),
     DiscoverPage(),
    //  SavedScreen(hotnews1: const {},),
     SavedPage(),
     ProfileScreen(),
  ];

  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: _pages[_selectedTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index) => _changeTab(index),
        selectedItemColor: Color(0xCC3FA20A),
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/discover.webp"),
                // color: Colors.black,
                size: 24,
              ),
              label: "Discover"),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_outline), label: "Saved"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined), label: "Profile"),
        ],
      ),
    );
  }
}

//======================================================================================//

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        // color: Colors.green,
        // height: double.infinity,
        // width: size.width,
        padding: EdgeInsets.symmetric(horizontal: 10),
        // color: Colors.green,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: size.height * 0.3,
              // color: Colors.red,
              child: NewsCategoryCarousel(),
            ),
            Container(
              // color: Colors.grey,
              height: size.height,
              width: size.width,
              child: TabBarWidget(),
            )
          ],
        ),
      ),
    );
  }
}

//===========================================================================================//





