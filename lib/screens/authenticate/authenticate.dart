/**
 * This is the authentication class loading background and front rendering of those signin and signup buttons
 */

import 'package:feed_box/screens/authenticate/signin.dart';
import 'package:feed_box/screens/authenticate/signup.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  String showSignIn = 'auth';

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 10), vsync: this)
          ..repeat();
  }

  //toggles to show whether to render
  void toggleView() {
    setState(() {
      showSignIn = 'auth';
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  //color tween
  Animatable<Color> background = TweenSequence<Color>([
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(
        begin: Colors.red,
        end: Colors.green,
      ),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(
        begin: Colors.green,
        end: Colors.blue,
      ),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(
        begin: Colors.blue,
        end: Colors.pink,
      ),
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    if (showSignIn == 'auth') {
      return AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return SafeArea(
              child: Scaffold(
                body: Container(
                  color: background
                      .evaluate(AlwaysStoppedAnimation(controller.value)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: 430,
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset('assets/communication.png',
                                fit: BoxFit.cover, width: 150),
                            SizedBox(height: 20),
                            Text('FeedBox',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: Colors.white))
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15))),
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 20),
                            Text('Welcome to FeedBox',
                                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                            SizedBox(height: 20),
                            Text(
                                'Now you can like, comment and share your post'),
                            SizedBox(height: 30),
                            Wrap(
                              children: <Widget>[
                                FlatButton(
                                  color: background.evaluate(
                                      AlwaysStoppedAnimation(controller.value)),
                                  onPressed: () {
                                    setState(() {
                                      showSignIn = 'signin';
                                    });
                                  },
                                  child: Text('Sign In',
                                      style: TextStyle(color: Colors.white)),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                FlatButton(
                                  color: Colors.white,
                                  onPressed: () {
                                    setState(() {
                                      showSignIn = 'signup';
                                    });
                                  },
                                  child: Text('Sign Up',
                                      style: TextStyle(
                                          color: background.evaluate(
                                              AlwaysStoppedAnimation(
                                                  controller.value)))),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
    } else if (showSignIn == 'signin') {
      return SignIn(toggleView: toggleView);
    } else {
      return SignUp(toggleView: toggleView);
    }
  }
}
