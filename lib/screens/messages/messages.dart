import 'package:flutter/material.dart';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {

void _showPostPanel() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.6,
            child: Container(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Message',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.add_circle), onPressed: () {
            _showPostPanel();
          }),
      body: Container(
        alignment: Alignment.center,
        child: Text('No New Messages'),
      ),
    );
  }
}
