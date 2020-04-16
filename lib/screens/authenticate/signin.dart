import 'package:feed_box/services/auth_service.dart';
import 'package:feed_box/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:feed_box/shared/constant.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> with SingleTickerProviderStateMixin {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  String email = '';
  String password = '';
  String error = '';

  AnimationController controller;

  void login() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });

      dynamic result = await _authService.signin(email, password);

      if (result == null) {
        setState(() {
          error = 'Invalid Credentials';
          loading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 10), vsync: this)
          ..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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
                    elevation: 0,
                    title: Text('FeedBox Sign In'),
                    centerTitle: true,
                    backgroundColor: background
                        .evaluate(AlwaysStoppedAnimation(controller.value)),
                    leading: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          widget.toggleView();
                        }),
                  ),
                  body: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: background
                          .evaluate(AlwaysStoppedAnimation(controller.value)),
                    ),
                    child: ListView(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(top: 50, bottom: 100),
                          child: SizedBox(
                            child: Image.asset('assets/communication.png'),
                            height: 150,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                                                ? 'Enter username/email'
                                                : null,
                                            decoration: textInputDecoration
                                                .copyWith(labelText: 'Email'),
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
                                            decoration:
                                                textInputDecoration.copyWith(
                                                    labelText: 'Password'),
                                          ),
                                          SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              FlatButton(
                                                onPressed: () async {
                                                  await login();
                                                },
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(20)),
                                                child: Text(
                                                  'Sign In',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                color: Colors.lightBlueAccent,
                                              ),
                                              FlatButton(
                                                onPressed: () {},
                                                child: Text('Forgot Password?'),
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
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
  }
}
