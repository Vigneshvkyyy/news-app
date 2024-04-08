// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SportsCategory extends StatefulWidget {
  @override
  _SportsCategoryState createState() => _SportsCategoryState();
}

class _SportsCategoryState extends State<SportsCategory> {
  List<dynamic> _articles = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    final response = await http.get(
      Uri.parse(
          'https://gnews.io/api/v4/top-headlines?topic=sports&token=7256acfa88ecf5f4bc4688a64449aedf'),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      setState(() {
        _articles = List<Map<String, dynamic>>.from(responseData['articles'])
            .map((article) {
          return {'data': article, 'isBookmarked': false};
        }).toList();
      });
    } else {
      throw Exception('Failed to load news');
    }
  }

  void toggleBookmark(int index) {
    setState(() {
      _articles[index]['isBookmarked'] = !_articles[index]['isBookmarked'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _articles.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              key: UniqueKey(),
              itemCount: _articles.length,
              itemBuilder: (context, index) {
                final article = _articles[index]['data'];
                final isBookmarked = _articles[index]['isBookmarked'];
                return ListTile(
                  trailing: IconButton(
                    icon: Icon(
                      isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      color: isBookmarked ? Color(0xCC3FA20A) : null,
                    ),
                    onPressed: () {
                      toggleBookmark(index);
                    },
                  ),
                  leading: article['image'] != null
                      ? Image.network(
                          article['image'],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                      : Icon(Icons.image),
                  title: Text(
                    // article['title'] ?? '',
                    article['source']['name'],
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article['title'] ?? '',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                      ),
                      Text(
                        article['publishedAt'] ?? '',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SportsDetailScreen(
                          sportsNews: article,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

//=====================================================================================//

class SportsDetailScreen extends StatefulWidget {
  final Map<String, dynamic> sportsNews;

  SportsDetailScreen({required this.sportsNews});

  @override
  State<SportsDetailScreen> createState() => _SportsDetailScreenState();
}

class _SportsDetailScreenState extends State<SportsDetailScreen> {
  bool isFavorite = false;

  bool isSaved = false;



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Happy Reading",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.grey.shade100,
            child: IconButton(
                onPressed: () {}, icon: Icon(Icons.more_horiz_rounded)),
          ),
          SizedBox(
            width: size.width * 0.02,
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(children: [
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
            child: Image.network(
              widget.sportsNews["image"] ?? "No Images", 
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Text(
            widget.sportsNews['title'] ?? 'No title',
         
            overflow: TextOverflow.clip,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                child: SizedBox(
                    width: 60,
                    height: 60,
                    child: ClipOval(
                      child: Image.network(
                        widget.sportsNews["image"] ?? "No Images",
                      ),
                    )),
              ),
              SizedBox(
                width: size.width * 0.02,
              ),
              Text(
                widget.sportsNews['source']['name'] ?? 'No author',
                maxLines: 1,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text(
                " •",
                textAlign: TextAlign.end,
                textHeightBehavior: TextHeightBehavior(),
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(
                width: size.width * 0.01,
              ),
              Flexible(
                child: Text(
                  widget.sportsNews['publishedAt'] ?? 'No publishedAt',
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 14,
                      // fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ),
            ],
          ),
          SizedBox(
            width: size.width * 0.03,
          ),
          Text(
            widget.sportsNews['description'] ?? 'No description',
            maxLines: 4,
            style: TextStyle(
                fontSize: 14,
                // fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Text(
            widget.sportsNews['content'] ?? 'No content',
            maxLines: 4,
            style: TextStyle(
                fontSize: 14,
                // fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
        ]),
      ),
      //===============================//======================================

      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 0),
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: size.height * 0.1,
            width: size.width * 0.87,
            child: FloatingActionButton(
              onPressed: () {},
              child: Container(
                height: size.height * 0.1,
                width: size.width / 1.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.shade100,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.04,
                    ),
                    Container(
                      height: size.height * 0.07,
                      width: size.width * 0.2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite
                                  ? Colors.red
                                  : null, 
                            ),
                            onPressed: () {
                              setState(() {
                                isFavorite =
                                    !isFavorite; 
                                
                              });
                            },
                          ),
                          Text(
                            "1.2K",
                            style: TextStyle(
                                fontSize: 8, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.01,
                    ),
                    Container(
                      height: size.height * 0.07,
                      width: size.width * 0.2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              isSaved ? Icons.bookmark : Icons.bookmark_border,
                              color: isSaved
                                  ? Color(0xCC3FA20A)
                                  : null, 
                            ),
                            onPressed: () {
                              setState(() {
                                isSaved = !isSaved; 
                              });
                            },
                          ),
                          Text(
                            "765",
                            style: TextStyle(
                                fontSize: 8, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.01,
                    ),
                    Container(
                      height: size.height * 0.07,
                      width: size.width * 0.2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.messenger_outline_rounded),
                          ),
                          Text(
                            "235",
                            style: TextStyle(
                                fontSize: 8, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.01,
                    ),
                    Container(
                      height: size.height * 0.07,
                      width: size.width * 0.2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.share_outlined),
                          ),
                          Text(
                            "32",
                            style: TextStyle(
                                fontSize: 8, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
