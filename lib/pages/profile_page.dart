import 'package:chatting/pages/home_page.dart';
import 'package:chatting/service/auth_service.dart';
import 'package:flutter/material.dart';

import '../widgets/forms.dart';
import 'auth/login_page.dart';

class ProfilePage extends StatefulWidget {
  String userName;
  String email;
  ProfilePage({Key? key, required this.userName, required this.email}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthService authService = AuthService();
  String userName = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Profile",
            style: TextStyle(
                color: Colors.white, fontSize: 27, fontWeight: FontWeight.bold),
          ),
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
            widget.userName,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Divider(
            height: 1,
          ),
          ListTile(
            onTap: () {
              nextScreen(context, const HomePage());
            },
            leading: const Icon(Icons.group),
            title: const Text("Groups",
            style: TextStyle(color: Colors.black),),
          ),
          ListTile(
            onTap: () {},
            selected: true,
            selectedColor: Colors.orange,
            leading: const Icon(Icons.groups),
            title: const Text("Profile",
              style: TextStyle(color: Colors.black),),
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
            title: const Text("LogOut",
              style: TextStyle(color: Colors.black),),
          )
        ])),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.account_circle,
            size: 200,
            color: Colors.grey[700],),
            const SizedBox(height: 15.5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Full Name", style: TextStyle(fontSize: 17),),
                Text(widget.userName, style: const TextStyle(fontSize: 17),)
              ],
            ),
            const Divider(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Email", style: TextStyle(fontSize: 17),),
                Text(widget.email, style: const TextStyle(fontSize: 17),)
              ],
            )
          ],
        ),
      ),
    );
  }
}
