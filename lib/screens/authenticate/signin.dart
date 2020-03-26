import 'package:feed_box/services/auth.dart';
import 'package:feed_box/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:feed_box/shared/constant.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment(1, 1),
                  colors: [const Color(0xFF1c92d2),const Color(0xFFf2fcfe),],
                )),
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                        child: SizedBox(
                          child: Image.asset('assets/communication.png'),
                          height: 150,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: Center(
                        child: ToggleSwitch(
                          minWidth: 90.0,
                          initialLabelIndex: 0,
                          activeBgColor: Colors.lightBlueAccent,
                          activeTextColor: Colors.white,
                          inactiveBgColor: Colors.white,
                          inactiveTextColor: Colors.black,
                          labels: ['SignIn', 'SignUp'],
                          onToggle: (index) {
                            if (index == 1) {
                              widget.toggleView();
                            }
                          },
                        ),
                      ),
                    ),
                    Padding(
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
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(children: <Widget>[
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          RaisedButton(
                                            onPressed: () async {
                                              if (_formKey.currentState
                                                  .validate()) {
                                                setState(() {
                                                  loading = true;
                                                });

                                                dynamic result =
                                                    await _authService.signin(
                                                        email, password);

                                                if (result == null) {
                                                  setState(() {
                                                    error =
                                                        'Invalid Credentials';
                                                    loading = false;
                                                  });
                                                }
                                              }
                                            },
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        10)),
                                            child: Text(
                                              'Sign In',
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
  }
}
