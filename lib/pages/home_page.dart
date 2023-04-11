import 'package:chatting/helper/helper_function.dart';
import 'package:chatting/pages/auth/login_page.dart';
import 'package:chatting/pages/profile_page.dart';
import 'package:chatting/pages/search_page.dart';
import 'package:chatting/service/auth_service.dart';
import 'package:chatting/widgets/forms.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../service/database_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = '';
  String email = '';
  AuthService authService = AuthService();
  Stream? groups;
  String groupName ='';
  bool _isloading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettingUserData();
  }

  gettingUserData() async {
    HelperFunctions.getUserEmailStatus().then((value) {
      setState(() {
        email = value!;
      });
    });
    await HelperFunctions.getUserNameStatus().then((value) {
      setState(() {
        userName = value!;
      });
    });
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserGroups()
        .then((snapshot) {
      setState(() {
        groups = snapshot;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                nextScreenReplace(context, const SearchPage());
              },
              icon: const Icon(Icons.search))
        ],
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.grey,
        title: const Text("Groups"),
      ),
      drawer: Drawer(
          child: ListView(children: [
        Icon(
          Icons.account_circle,
          size: 150,
          color: Colors.grey[700],
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          userName,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const Divider(
          height: 1,
        ),
        ListTile(
          onTap: () {},
          leading: const Icon(Icons.group),
          title: const Text("Groups"),
        ),
        ListTile(
          onTap: () {
            nextScreenReplace(
                context, ProfilePage(userName: userName, email: email));
          },
          leading: const Icon(Icons.groups),
          title: const Text("Profile"),
        ),
        ListTile(
          onTap: () async {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Logout"),
                    content: const Text("Are you want to sure logout ?"),
                    actions: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.cancel, color: Colors.red)),
                      IconButton(
                          onPressed: () async {
                            await authService.signOut();
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                                (route) => false);
                          },
                          icon: const Icon(Icons.exit_to_app,
                              color: Colors.green))
                    ],
                  );
                });
          },
          leading: const Icon(Icons.exit_to_app),
          title: const Text("LogOut"),
        )
      ])),
      body: groupList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          popUpDialog(context);
        },
        backgroundColor: Colors.orange,
        child: const Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }

  popUpDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              "Create a group",
              textAlign: TextAlign.left,
            ),
            content: _isloading == true ? const CircularProgressIndicator() :  TextField(
              onChanged: (value){
                setState(() {
                  groupName = value;
                });
              },
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide (color: Colors.orangeAccent,
                  ),
                  borderRadius: BorderRadius.circular(20)
                ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.lightGreen,
                      ),
                      borderRadius: BorderRadius.circular(20)
                  ),
                errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.redAccent,
                    ),
                    borderRadius: BorderRadius.circular(20)
                ),
              ),
            ),
            actions: [
              ElevatedButton(onPressed: (){
                Navigator.pop(context);
              },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red
                ),
                child: const Text("Cancel"),

              ),
              ElevatedButton(onPressed: (){
                if(groupName != ""){
                  setState(() {
                    _isloading = true;
                  });
                  DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).CreatGroup(userName, FirebaseAuth.instance.currentUser!.uid, groupName).whenComplete(() {
                    _isloading = false;
                  });
                  Navigator.of(context).pop();
                  showSnackBar(context, Colors.green , "Group created successfully");
                }
              },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green),
                  child: const Text("Create"))
            ],
          );
        });
  }

  groupList() {
    return StreamBuilder(
        stream: groups,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data['groups'] != null) {
              if (snapshot.data['groups'].length != 0) {
                return const Text("hello");
              } else {
                return noGroupWidget();
              }
            } else {
              return noGroupWidget();
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.deepOrangeAccent,
              ),
            );
          }
        });
  }

  noGroupWidget() {
    return Container(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              popUpDialog(context);
            },
            child: Icon(
              Icons.add_circle,
              color: Colors.grey[700],
              size: 75,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "You have not joined any groups, "
            "tap on add icon to create a group or also search on top icon button",
            textAlign: TextAlign.center,
          )
        ],
      ),
    ));
  }
}
