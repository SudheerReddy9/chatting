import 'package:chatting/pages/auth/register_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../widgets/forms.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
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
                  "Login to make new friends!",
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
                SizedBox(height: 20),
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
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ))),
                Text.rich(
                  TextSpan(
                    text: "Don't have an account?",
                    children: <TextSpan>[
                      TextSpan(text: "Register Here",
                      style: TextStyle(color: Colors.black,decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()..onTap = (){
                        NextScreen(context, RegisterPage());
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
