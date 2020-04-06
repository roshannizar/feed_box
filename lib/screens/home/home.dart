import 'package:feed_box/screens/feeds/feed.dart';
import 'package:feed_box/screens/messages/messages.dart';
import 'package:feed_box/screens/profile/profile.dart';
import 'package:feed_box/services/push_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:feed_box/screens/search/search.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int bottomIndex = 0;

  @override
  void initState() {
    super.initState();
    PushNotifcationService().initialise();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
                gap: 8,
                activeColor: Colors.white,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                duration: Duration(milliseconds: 800),
                tabBackgroundColor: Colors.blue,
                tabs: [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.search,
                    text: 'Search',
                  ),
                  GButton(
                    icon: Icons.add_box,
                    iconColor: Colors.blue,
                    text: 'New Post',
                  ),
                  GButton(
                    icon: Icons.message,
                    text: 'Message',
                  ),
                  GButton(
                    icon: Icons.person,
                    text: 'Profile',
                  ),
                ],
                selectedIndex: bottomIndex,
                onTabChange: (index) {
                  if (index == 2) {
                    Navigator.pushNamed(context, '/newpost');
                  } else {
                    setState(() {
                      bottomIndex = index;
                    });
                  }
                }),
          ),
        ),
      ),
      body: SafeArea(
        child: bottomIndex == 0
            ? Feed()
            : bottomIndex == 1
                ? Search()
                : bottomIndex == 3 ? Messages() : Profile(),
      ),
    );
  }
}
