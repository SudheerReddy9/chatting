import 'package:chatting/pages/auth/login_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../widgets/forms.dart';
class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  String fullName = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        child: Form(
          key: formKey,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Groupie",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "create your account to chat a",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
                const Spacer(),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                      hintText: "Email", prefixIcon: Icon(Icons.email)),
                  onChanged: (value) {
                    setState(() {
                      email = value;
                      print(email);
                    });
                  },
                  validator: (value) {
                    return RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+"
                        r"@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value!)
                        ? null
                        : "Please Check the entered Email";
                  },
                ),
                SizedBox(height: 15,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                      hintText: "Full Name",
                      prefixIcon: Icon(Icons.person)),
                  onChanged: (value) {
                    setState(() {
                      email = value;
                      print(email);
                    });
                  },
                  validator: (value) {
                    if(value!.isNotEmpty){
                      return null;
                    }
                    else{
                      return "Please cannot be Empty";
                    }
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  obscureText: true,
                  decoration: textInputDecoration.copyWith(
                      hintText: "Password",
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: Icon(Icons.remove_red_eye_rounded)),
                  onChanged: (value) {
                    setState(() {
                      password = value;
                      print(password);
                    });
                  },
                  validator: (value) {
                    if (value!.length < 8) {
                      return "Passord Must be atleast 8 characters";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                // ElevatedButton(onPressed: () {
                //
                //   login();
                // }, child: Text("login"))
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))),
                        onPressed: () {

                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ))),
                Text.rich(
                  TextSpan(
                      text: "Alraedy have an account?",
                      children: <TextSpan>[
                        TextSpan(text: "Login Now",
                            style: TextStyle(color: Colors.black,decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()..onTap = (){
                              NextScreen(context, LoginPage());
                            }
                        )
                      ]
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
