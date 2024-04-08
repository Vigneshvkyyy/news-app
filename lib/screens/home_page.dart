import 'package:flutter/material.dart';

import '../widgets/bottom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ANTUVN",
          style: TextStyle(
              fontFamily: 'font',
              color: Color(0xCC3FA20A),
              fontWeight: FontWeight.bold),
        ),
        actions: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey.shade100,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_none_rounded,
              ),
            ),
          ),
          SizedBox(
            width: size.width * 0.04,
          ),
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey.shade100,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search_rounded,
              ),
            ),
          ),
          SizedBox(
            width: size.width * 0.02,
          ),
        ],
      ),
      body: BottomNavigationExample(),
    );
  }
}
