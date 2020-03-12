import 'package:flutter/material.dart';
import 'package:feed_box/models/post.dart';

class FeedTile extends StatelessWidget {
  final Post post;
  FeedTile({this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(4,5,4,5),
      decoration: new BoxDecoration(
          color: Colors.grey[100],
          borderRadius: new BorderRadius.all(Radius.circular(10.0))),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 15,
                  child: Text('RS',style: TextStyle(fontSize: 12),),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text('${post.fullname}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
                Expanded(
                  child: Container(
                    height: 20,
                    width:10,
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20)),
                      child: Text(
                        'Follow',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
              child: Text(
                  '${post.description}'),
            ),
            Divider(color: Colors.grey[700]),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                FlatButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.favorite_border, size: 15),
                    label: Text('12')),
                FlatButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.comment, size: 15),
                    label: Text('1')),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: FlatButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.share, size: 15),
                        label: Text('Share')),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
