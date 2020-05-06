/**
 * signup class using animation back color tween
 */

import 'package:feed_box/services/auth_service.dart';
import 'package:feed_box/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:feed_box/shared/constant.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;
  SignUp({this.toggleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  AnimationController controller;

  bool loading = false;
  String email = '';
  String password = '';
  String confirmpassword = '';
  String fullname = '';
  String error = '';

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 10), vsync: this)
          ..repeat();
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
    return loading
        ? Loading()
        : AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return SafeArea(
                child: Scaffold(
                  appBar: AppBar(
                    title: Text('FeedBox Signup'),
                    centerTitle: true,
                    elevation: 0,
                    backgroundColor: background.evaluate(
                            AlwaysStoppedAnimation(controller.value)),
                    leading: IconButton(
                      onPressed: (){
                        widget.toggleView();
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
                  ),
                  body: Container(
                    decoration: BoxDecoration(
                        color: background.evaluate(
                            AlwaysStoppedAnimation(controller.value))),
                    child: ListView(
                      children: <Widget>[
                        Container(
                            padding: const EdgeInsets.only(top:25,bottom: 30),
                            child: SizedBox(
                              child: Image.asset('assets/communication.png'),
                              height: 80,
                            ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                    decoration: new BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius: new BorderRadius.all(
                                            Radius.circular(10.0))),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 10, 10, 10),
                                      child: Form(
                                        key: _formKey,
                                        child: Column(children: <Widget>[
                                          SizedBox(height: 20),
                                          TextFormField(
                                            validator: (val) => val.isEmpty
                                                ? 'Enter Full Name'
                                                : null,
                                            decoration:
                                                textInputDecoration.copyWith(
                                                    hintText: 'Full Name'),
                                            onChanged: (value) {
                                              setState(() {
                                                fullname = value;
                                              });
                                            },
                                          ),
                                          SizedBox(height: 20),
                                          TextFormField(
                                            validator: (val) => val.isEmpty
                                                ? 'Enter username/email'
                                                : null,
                                            decoration: textInputDecoration
                                                .copyWith(hintText: 'Email'),
                                            onChanged: (value) {
                                              setState(() {
                                                email = value;
                                              });
                                            },
                                          ),
                                          SizedBox(height: 20),
                                          TextFormField(
                                            validator: (val) => val.length < 6
                                                ? 'should be atleast 6+ characters'
                                                : null,
                                            onChanged: (value) {
                                              setState(() {
                                                password = value;
                                              });
                                            },
                                            obscureText: true,
                                            decoration: textInputDecoration
                                                .copyWith(hintText: 'Password'),
                                          ),
                                          SizedBox(height: 20),
                                          TextFormField(
                                            validator: (val) => val != password
                                                ? 'should be atleast 6+ characters'
                                                : null,
                                            onChanged: (value) {
                                              setState(() {
                                                confirmpassword = value;
                                              });
                                            },
                                            obscureText: true,
                                            decoration:
                                                textInputDecoration.copyWith(
                                                    hintText:
                                                        'Confirm Password'),
                                          ),
                                          SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              FlatButton(
                                                onPressed: () async {
                                                  if (_formKey.currentState
                                                      .validate()) {
                                                    setState(() {
                                                      loading = true;
                                                    });

                                                    dynamic result =
                                                        await _authService
                                                            .signup(
                                                                email,
                                                                password,
                                                                fullname);

                                                    if (result == null) {
                                                      setState(() {
                                                        error =
                                                            'Invalid details';
                                                        loading = false;
                                                      });
                                                    }
                                                  }
                                                },
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(10)),
                                                child: Text(
                                                  'Sign Up',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                color: Colors.lightBlueAccent,
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 2),
                                          Text(error,
                                              style: TextStyle(
                                                  color: Colors.redAccent))
                                        ]),
                                      ),
                                    )),
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
  }
}
