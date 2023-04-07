import 'package:chatting/service/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  //login
// register
  Future registerUserWithEmailandPassword(
      String fullName, String email, String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;
      if(user != null){
        DatabaseService(uid: user.uid).updateUserData(fullName, email);
        return true;
      }else{}
    } on FirebaseAuthException catch (e) {
      print(e);
      return e.message;
    }
  }

// signout
}
