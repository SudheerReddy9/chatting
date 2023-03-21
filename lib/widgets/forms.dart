import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w300
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent,width: 2)
  ),
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey,width: 2)
  ),
  errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red,width: 2)
  ),
);
void NextScreen(context, page){
  Navigator.push(context, MaterialPageRoute(builder: ((context) => page)));
}