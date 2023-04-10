import 'package:chatting/helper/helper_function.dart';
import 'package:chatting/pages/auth/login_page.dart';
import 'package:chatting/pages/home_page.dart';
import 'package:chatting/service/auth_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../widgets/forms.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  bool _isloading = false;
  String fullName = "";
  String email = "";
  String password = "";
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isloading
          ? const Center(
              child: SpinKitPouringHourGlassRefined(
              size: 50,
              duration: Duration(seconds: 10),
              strokeWidth: 2,
              color: Colors.orange,
            ))
          : Padding(
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
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        "create your account to chat ",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                      const Spacer(),

                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: "Full Name",
                            prefixIcon: const Icon(Icons.person)),
                        onChanged: (value) {
                          setState(() {
                            fullName = value;
                            //print(email);
                          });
                        },
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            return null;
                          } else {
                            return "Please cannot be Empty";
                          }
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: "Email",
                              prefixIcon: const Icon(Icons.email)),
                          onChanged: (value) {
                            setState(() {
                              email = value;
                              //print(email);
                            });
                          },
                          // validator: (value) {
                          //   return RegExp(
                          //              // r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          //                 r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          //           .hasMatch(value!)
                          //       ? null
                          //       : "Please Check the entered Email";
                          // },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter the email";
                            } else if (!value.contains('@gmail.com')) {
                              return 'Please enter the valid email';
                            } else if (!RegExp(r'^[a-zA-z0-9@.]+$').hasMatch(value)){
                              return 'Please enter the valid email';
                            }
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: textInputDecoration.copyWith(
                            hintText: "Password",
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon:
                                const Icon(Icons.remove_red_eye_rounded)),
                        onChanged: (value) {
                          setState(() {
                            password = value;
                            //print(password);
                          });
                        },
                        validator: (value) {
                          if (value!.length < 8) {
                            return "Password Must be least 8 characters";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 20),
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
                                register();

                              },

                              child: const Text(
                                "Register",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ))),
                      Text.rich(
                        TextSpan(
                            text: "Already have an account?",
                            children: <TextSpan>[
                              TextSpan(
                                  text: "Login Now",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      nextScreen(context, const LoginPage());
                                    })
                            ]),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  register() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isloading = true;
      });
      await authService
          .registerUserWithEmailandPassword(fullName, email, password)
          .then((value) async {
        if (value == true) {
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailStatus(email);
          await HelperFunctions.saveUserNameStatus(fullName);

          nextScreenReplace(context, const HomePage());
        } else {
          showSnackBar(context, Colors.red, value);
          setState(() {
            _isloading = false;
          });
        }
      });
    }
  }
}
