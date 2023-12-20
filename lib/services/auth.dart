import 'package:coffee/models/myuser.dart';
import 'package:coffee/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyUser? _myUserFromUser(User? user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  Stream<MyUser?> get user {
    return _auth.authStateChanges().map(_myUserFromUser);
  }

  // anon sign in
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user; 
      return _myUserFromUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // sign in
  Future SignInUser(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _myUserFromUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // register
  Future RegisterUser(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      await DatabaseService(uid: user!.uid).updateUserData('0', 'new member', 100);

      return _myUserFromUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

}