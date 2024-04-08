// ignore_for_file: use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class DiscoverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildCategorySection(),
            _buildPopularArticles(),
            _buildTrendingTopics(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection() {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.green[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Categories',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: <Widget>[
              Chip(label: Text('Politics')),
              Chip(label: Text('Technology')),
              Chip(label: Text('Sports')),
              Chip(label: Text('Entertainment')),
              Chip(label: Text('Science')),
              Chip(label: Text('Health')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPopularArticles() {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.orange[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Popular Articles',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          ListTile(
            leading: Icon(Icons.article),
            title: Text('Article 1'),
            subtitle: Text('Description of Article 1'),
            onTap: () {
            },
          ),
          ListTile(
            leading: Icon(Icons.article),
            title: Text('Article 2'),
            subtitle: Text('Description of Article 2'),
            onTap: () {
            },
          ),
          ListTile(
            leading: Icon(Icons.article),
            title: Text('Article 3'),
            subtitle: Text('Description of Article 3'),
            onTap: () {
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingTopics() {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.purple[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Trending Topics',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: <Widget>[
              Chip(label: Text('Elections')),
              Chip(label: Text('AI')),
              Chip(label: Text('Football')),
              Chip(label: Text('Movies')),
              Chip(label: Text('Space Exploration')),
            ],
          ),
        ],
      ),
    );
  }
}
