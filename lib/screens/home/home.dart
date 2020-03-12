import 'package:feed_box/screens/messages/messages.dart';
import 'package:feed_box/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:feed_box/screens/home/feed.dart';
import 'package:feed_box/screens/search/search.dart';
import 'package:feed_box/screens/postpanel/post_panel.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int bottomIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavyBar(
        currentIndex: bottomIndex,
        onItemSelected: (index) => setState(() {
          bottomIndex = index;
        }),
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            activeColor: Colors.blueAccent,
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.search),
              title: Text('Search'),
              activeColor: Colors.blueAccent),
          BottomNavyBarItem(
              icon: Icon(Icons.add_circle),
              title: Text('New Post'),
              activeColor: Colors.blueAccent),
          BottomNavyBarItem(
              icon: Icon(Icons.message),
              title: Text('Messages'),
              activeColor: Colors.blueAccent),
          BottomNavyBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile'),
              activeColor: Colors.blueAccent),
        ],
      ),
      body: SafeArea(
        child: bottomIndex == 0
            ? Feed()
            : bottomIndex == 1
                ? Search()
                : bottomIndex == 2 ? PostPanel() : bottomIndex == 3 ? Messages() : Profile(),
      ),
    );
  }
}
