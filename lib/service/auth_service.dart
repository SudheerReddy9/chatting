import 'package:chatting/service/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../helper/helper_function.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  //login

  Future loginWithUserNameandPassword(
      String email, String password) async {
    try {
      User? user = (await firebaseAuth.signInWithEmailAndPassword(email: email, password: password))
          .user;
      if(user != null){
        return true;
      }else{}
    } on FirebaseAuthException catch (e) {
      //print(e);
      return e.message;
    }
  }




// register
  Future registerUserWithEmailandPassword(
      String fullName, String email, String password) async {
    try {
      User? user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
      if(user != null){
        await DatabaseService(uid: user.uid).updateUserData(fullName, email);
        print(fullName);
        return true;
      }else{}
    } on FirebaseAuthException catch (e) {
      //print(e);
      return e.message;
    }
  }

// signout
 Future signOut() async{
    try{
      await HelperFunctions.saveUserLoggedInStatus(false);
      await HelperFunctions.saveUserEmailStatus("");
      await HelperFunctions.saveUserNameStatus("");
      await firebaseAuth.signOut();
    } catch (e){
      return null;
    }
 }
}
