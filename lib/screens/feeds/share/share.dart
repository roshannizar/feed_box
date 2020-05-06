/**
 * Share dart file 
 */

import 'package:flutter/material.dart';
import 'package:share/share.dart';

class ShareContainer extends StatelessWidget {
  final String postUrl, description;
  ShareContainer({this.postUrl, this.description});
  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
        onPressed: () {
          Share.share('$postUrl', subject: '$description');
        },
        label: Text('Share'),
        icon: Icon(Icons.share, size: 15));
  }
}
