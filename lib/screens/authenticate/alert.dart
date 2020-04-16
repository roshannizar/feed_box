import 'package:feed_box/services/auth_service.dart';
import 'package:feed_box/shared/constant.dart';
import 'package:flutter/material.dart';

class Alert extends StatefulWidget {
  @override
  _AlertState createState() => _AlertState();
}

class _AlertState extends State<Alert> {
  bool forgot = false;
  String email;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Forgot Password'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Container(
        height: 125,
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                child: TextFormField(
                  decoration: textInputDecoration.copyWith(
                    labelText: 'Email',
                  ),
                  onChanged: (val) => setState(() => email = val),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: FlatButton(
                  onPressed: () async {
                    try {
                      setState(() {
                        forgot = true;
                      });
                      await AuthService().resetPassword(email);
                      showDialog(
                          context: this.context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Success'),
                              content: Text('Check your mail address'),
                            );
                          });
                      setState(() {
                        forgot = false;
                      });
                      Navigator.pop(context);
                    } catch (e) {
                      setState(() {
                        forgot = false;
                      });
                      showDialog(
                          context: this.context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content: Text('Something went wrong, maybe wrong email!'),
                            );
                          });
                      Navigator.pop(context);
                    }
                  },
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: forgot
                      ? Text('Loading...')
                      : Text('Submit', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
