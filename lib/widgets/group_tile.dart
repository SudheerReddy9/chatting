import 'package:chatting/widgets/forms.dart';
import 'package:flutter/material.dart';

import '../pages/auth/chat_page.dart';

class GroupTile extends StatefulWidget {
  const GroupTile(
      {Key? key,
      required this.userName,
      required this.groupId,
      required this.groupName})
      : super(key: key);
  final String userName;
  final String groupId;
  final String groupName;
  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        nextScreen(context, ChatPage(groupId: widget.groupId, groupName: widget.groupName, userName: widget.userName,

        ));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            child: Text(
              widget.groupName.substring(0,1).toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
          title: Text(widget.groupName, style: TextStyle(fontWeight: FontWeight.bold),),
          subtitle: Text("Join the conversation as ${widget.userName}"),
        ),
      ),
    );
  }
}
