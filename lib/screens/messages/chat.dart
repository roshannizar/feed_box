import 'package:feed_box/models/chat_model.dart';
import 'package:feed_box/models/profile.dart';
import 'package:feed_box/models/user.dart';
import 'package:feed_box/screens/messages/chat_container.dart';
import 'package:feed_box/services/message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> with SingleTickerProviderStateMixin {
  String content;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final ProfileModel args = ModalRoute.of(context).settings.arguments;

    return StreamProvider<List<ChatModel>>.value(
      value:
          MessageService(uid: user.uid, to: 'Raeez', fromUid: args.uid).myChat,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
            ),
            title: Text('Nawzath', style: TextStyle(color: Colors.white)),
            subtitle: Text('online', style: TextStyle(color: Colors.white)),
          ),
        ),
        body: ChatContainer(),
        bottomNavigationBar: TextFormField(
            onChanged: (value) {
              setState(() {
                content = value;
              });
            },
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                hintText: 'Type your message ...',
                border: InputBorder.none,
                prefixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.perm_media),
                ),
                suffixIcon: IconButton(
                  onPressed: () async {
                    await MessageService(
                            uid: user.uid, to: 'Raeez', fromUid: args.uid)
                        .sendMessage(user.uid, 'Raeez', content);
                  },
                  icon: Icon(Icons.send),
                ))),
      ),
    );
  }
}
