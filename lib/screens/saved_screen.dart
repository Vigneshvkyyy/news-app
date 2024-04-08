import 'package:flutter/material.dart';

class SavedScreen extends StatefulWidget {
  final Map<String, dynamic> hotnews1;
  const SavedScreen({
    Key? key,
    required this.hotnews1,
  }) : super(key: key);

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: size.height * 0.1,
        ),
        Text(
          "Saved Items ",
          style: TextStyle(fontSize: 22),
        ),
        ListTile(
          leading: widget.hotnews1['image'] != null
              ? SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.network(
                    widget.hotnews1['image'],
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                )
              : Icon(Icons.image),
          minLeadingWidth: 0.0,
          title: Text(
            widget.hotnews1['source']['name'] ?? 'No Saved data',
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.hotnews1['title'] ?? '',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
              ),
              Text(
                widget.hotnews1['publishedAt'] ?? '',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          onTap: () {},
        )
      ],
    ));
  }
}
