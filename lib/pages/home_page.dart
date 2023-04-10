import 'package:chatting/helper/helper_function.dart';
import 'package:chatting/pages/search_page.dart';
import 'package:chatting/service/auth_service.dart';
import 'package:chatting/widgets/forms.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = '';
  String email = '';
  AuthService authService = AuthService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettingUserData();
  }

  gettingUserData(){
    HelperFunctions.getUserEmailStatus().then((value) {
      setState(() {
        email = value!;
      });
    });
    HelperFunctions.getUserNameStatus().then((value) {
      setState(() {
        userName = value!;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            nextScreen(context, const SearchPage());
          }, icon: const Icon(Icons.search))
        ],
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.grey,
        title: const Text("Groups"),
      ),
      drawer : Drawer(
        child : ListView(
          children: [
            Icon(Icons.account_circle,size: 150,color: Colors.grey[700],),

           const SizedBox(
              height: 15,
            ),
            Text(userName,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),),
            const Divider(
              height: 1,
            ),
            ListTile(
              onTap: (){},
              leading: const Icon(Icons.group),
              title: const Text("Groups"),
            ),
            ListTile(
              onTap: (){},
              leading: const Icon(Icons.groups),
              title: const Text("Profile"),
            ),
            ListTile(
              onTap: (){},
              leading: const Icon(Icons.exit_to_app),
              title: const Text("Groups"),
            )

          ]
        )
      )

    );
  }
}
