import 'package:feed_box/models/user.dart';
import 'package:feed_box/services/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //User model
  User _user(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //Auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_user);
  }

  //User Signin
  Future signin(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _user(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //User Signup
  Future signup(String email, String password,String fullname) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      await ProfileService(uid: user.uid).updateProfile(fullname);
      return _user(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //User Signout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
