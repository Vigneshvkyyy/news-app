// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';

class Article {
  final String title;
  final String description;
  final String imageUrl;

  Article(this.title, this.description, this.imageUrl);
}

class SavedPage extends StatefulWidget {
  @override
  _SavedPageState createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  List<Article> savedArticles = [
    Article(
      'Title of Saved Article 1',
      'Description of Saved Article 1',
      'https://via.placeholder.com/150',
    ),
    Article(
      'Title of Saved Article 2',
      'Description of Saved Article 2',
      'https://via.placeholder.com/150',
    ),
    Article(
      'Title of Saved Article 3',
      'Description of Saved Article 3',
      'https://via.placeholder.com/150',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: savedArticles.isEmpty
          ? Center(
              child: Text(
                'No saved articles yet.',
                style: TextStyle(fontSize: 24),
              ),
            )
          : ListView.builder(
              itemCount: savedArticles.length,
              itemBuilder: (context, index) {
                return _buildArticleTile(savedArticles[index]);
              },
            ),
    );
  }

  Widget _buildArticleTile(Article article) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(8.0),
        leading: Image.network(
          article.imageUrl,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        title: Text(
          article.title,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          article.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            setState(() {
              savedArticles.removeAt(savedArticles.indexOf(article));
            });
          },
        ),
      ),
    );
  }
}
