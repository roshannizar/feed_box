/**
 * Empty rendering class
 */

import 'package:flutter/material.dart';

class Empty extends StatefulWidget {
  final String imageUrl; //takes image url for different screens
  final String text; // text to appear
  Empty({this.imageUrl, this.text});
  @override
  _EmptyState createState() => _EmptyState();
}

class _EmptyState extends State<Empty> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset('${widget.imageUrl}', width: 100),
            SizedBox(
              height: 20,
            ),
            Text(
              '${widget.text}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
