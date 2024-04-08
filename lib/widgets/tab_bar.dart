// ignore_for_file: prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, library_private_types_in_public_api, avoid_unnecessary_containers

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:task_project/category/environment_category.dart';

import '../category/health_category.dart';
import '../category/politic_category.dart';
import '../category/sports_category.dart';
import '../category/hotnews_category.dart';
import '../category/technology_category.dart';

class TabBarWidget extends StatefulWidget {
  // TabBar({Key? key}) : super(key: key);

  @override
  _TabBarWidgetState createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 6,
          child: Column(
            children: <Widget>[
              ButtonsTabBar(
                radius: 20,
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                backgroundColor: Color(0xCC3FA20A),
                unselectedBackgroundColor: Colors.grey.shade100,
                unselectedLabelStyle: TextStyle(color: Colors.grey),
                labelStyle:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: [
                  Tab(
                    text: "Hot News",
                  ),
                  Tab(
                    text: "Sports",
                  ),
                  Tab(
                    text: "Politic",
                  ),
                  Tab(
                    text: "Health",
                  ),
                  Tab(
                    text: "Environment",
                  ),
                  Tab(
                    text: "Technology",
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    Container(child: HotnewsCategory()),
                    Container(child: SportsCategory()),
                    Container(child: PoliticCategory()),
                    Container(child: HealthCategory()),
                    Container(child: EnvironmentCategory()),
                    Container(child: TechnologyCategory()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
