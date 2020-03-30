import 'package:feed_box/models/chat_model.dart';
import 'package:feed_box/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatContainer extends StatefulWidget {
  @override
  _ChatContainerState createState() => _ChatContainerState();
}

class _ChatContainerState extends State<ChatContainer> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    final chat = Provider.of<List<ChatModel>>(context) ?? [];

    return ListView.builder(
      reverse: true,
      itemCount: chat.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            user.uid == chat[index].from
                ? Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.bottomRight,
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        color: Colors.amber,
                        child: Text('${chat[index].content}')),
                  )
                : Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.bottomLeft,
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        color: Colors.amber,
                        child: Text('${chat[index].content}')),
                  )
          ],
        );
      },
    );
  }
}
