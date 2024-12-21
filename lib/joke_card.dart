import 'package:flutter/material.dart';
import 'dart:math';

class CardExample extends StatelessWidget {
  final String title;
  final String subtitle;
  final String tag;

  const CardExample({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> emojis = ['😊', '😂', '😄', '😁', '😆', '😅', '🤣'];
    final String randomEmoji = emojis[Random().nextInt(emojis.length)];

    return Center(
      child: Card(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Text(randomEmoji, style: TextStyle(fontSize: 24)),
                title: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(subtitle),
              ),
              SizedBox(height: 1.0), // Add a 1px gap between ListTile and tag
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  padding: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.tag, size: 16.0),
                      SizedBox(width: 4.0),
                      Text(tag),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}