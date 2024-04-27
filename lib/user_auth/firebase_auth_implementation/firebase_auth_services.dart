
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService{
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    }catch(e){
      print(e);
      return null;
    }
  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    }catch(e){
      print(e);
      return null;
    }
  }
  Future<void> sendEmailVerification() async {
    User? user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    } else {
      throw Exception("No user logged in or email already verified.");
    }
  }
}