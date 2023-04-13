import 'package:chatting/pages/group_info.dart';
import 'package:chatting/service/database_service.dart';
import 'package:chatting/widgets/forms.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage(
      {Key? key,
      required this.groupId,
      required this.groupName,
      required this.userName})
      : super(key: key);

  final String groupId;
  final String groupName;
  final String userName;
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late Stream<QuerySnapshot> chats;
  String admin = "";

  @override
  void initState() {
    getchatandadmin();
    
    super.initState();
  }
  getchatandadmin(){
 DatabaseService().getChats(widget.groupId).then((value){
   setState(() {
     chats = value;
   });
 });
 DatabaseService().getGroupadmin(widget.groupId).then((value){
   setState(() {
     admin = value;
   });
 });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.groupName),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                nextScreen(
                    context,
                    GroupInfo(
                      groupId: widget.groupId,
                      groupName: widget.groupName,
                      adminName: admin,
                    ));
              },
              icon: Icon(Icons.info))
        ],
      ),
      body: Center(child: Text(widget.groupName)),
    );
  }
}
