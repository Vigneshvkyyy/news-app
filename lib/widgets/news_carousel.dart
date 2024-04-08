// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, avoid_print, use_rethrow_when_possible, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';

class NewsCategoryCarousel extends StatefulWidget {
  @override
  _NewsCategoryCarouselState createState() => _NewsCategoryCarouselState();
}

class _NewsCategoryCarouselState extends State<NewsCategoryCarousel> {
  List<dynamic> _categories = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse(
          'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=736df975f479494da64fc0dea2df1df0'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        setState(() {
          _categories = responseData['articles'];
        });
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: _categories.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.03,
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    // aspectRatio: 16 / 12,
                    height: 150,
                    viewportFraction: 0.8,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlay: true,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index, reason) {
                      setState(
                        () {
                          _currentIndex = index;
                        },
                      );
                    },
                  ),
                  items: _categories.map((category) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryDetailScreen(
                              categorys: category,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            // color: Colors.amber,
                            ),
                        child: Card(
                          elevation: 1.0,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                            child: Stack(
                              children: [
                                Image.network(
                                    category["urlToImage"] ?? "No Images",
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover),
                                Positioned(
                                  // top: 20,
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Text(
                                      category['title'] ?? 'No title',
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 20,
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          child: SizedBox(
                                              width: 60,
                                              height: 60,
                                              child: ClipOval(
                                                child: Image.network(
                                                  category["urlToImage"] ??
                                                      "No Images",
                                                ),
                                              )),
                                        ),
                                        Text(
                                          category['author'] ?? 'No author',
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                //========================================================================
                Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: _categories.map((urlOfItem) {
                        int index = _categories.indexOf(urlOfItem);
                        return Container(
                          width: 10.0,
                          height: 5.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: _currentIndex == index
                                ? Color(0xCC3FA20A)
                                : Colors.grey.shade200,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                )
              ],
            ),
    );
  }
}

// buider remove

//=============================================================================//

class CategoryDetailScreen extends StatefulWidget {
  final Map<String, dynamic> categorys;

  CategoryDetailScreen({required this.categorys});

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
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
              widget.categorys["urlToImage"] ?? "No Images", // happy reading
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Text(
            widget.categorys['title'] ?? 'No title',
            // maxLines: 2,
            // textAlign: TextAlign.center,
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
                        widget.categorys["urlToImage"] ?? "No Images",
                      ),
                    )),
              ),
              SizedBox(
                width: size.width * 0.02,
              ),
              Text(
                widget.categorys['author'] ?? 'No author',
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
                  widget.categorys['publishedAt'] ?? 'No publishedAt',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  // textWidthBasis: TextWidthBasis.longestLine,
                  // softWrap: false,
                  style: TextStyle(
                      fontSize: 12,
                      // fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ),
            ],
          ),
          // SizedBox(
          //   height: size.height * 0.03,
          // ),
          Text(
            widget.categorys['content'] ?? 'No content',
            maxLines: 4,
            // softWrap: true,
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Text(
            widget.categorys['description'] ?? 'No description',
            maxLines: 4,
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
          SizedBox(
            height: size.height * 0.08,
          ),
        ]),
      ),
      //========================================================================//

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
                height: size.height * 0.14,
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
                              color: isFavorite ? Colors.red : null,
                            ),
                            onPressed: () {
                              setState(() {
                                isFavorite = !isFavorite;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('Hi,Article added to Favourite'),
                                  backgroundColor: Colors.teal,
                                  dismissDirection: DismissDirection.horizontal,
                                  behavior: SnackBarBehavior.fixed,
                                  padding: EdgeInsets.all(10),
                                  duration: Duration(milliseconds: 1000),
                                  action: SnackBarAction(
                                    label: 'Dismiss',
                                    disabledTextColor: Colors.white,
                                    textColor: Colors.yellow,
                                    onPressed: () {},
                                  ),
                                ),
                              );
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
                              color: isSaved ? Color(0xCC3FA20A) : null,
                            ),
                            onPressed: () {
                              setState(() {
                                isSaved = !isSaved;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Hi,Article added to Saved'),
                                  backgroundColor: Colors.teal,
                                  dismissDirection: DismissDirection.horizontal,
                                  behavior: SnackBarBehavior.fixed,
                                  padding: EdgeInsets.all(10),
                                  duration: Duration(milliseconds: 1000),
                                  action: SnackBarAction(
                                    label: 'Dismiss',
                                    disabledTextColor: Colors.white,
                                    textColor: Colors.yellow,
                                    onPressed: () {},
                                  ),
                                ),
                              );
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
