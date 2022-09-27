import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'auth_bloc.dart';

class FirAuth {
  FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;

  void signUp(String email, String pass, String name, String passcomfirn,
      Function onSuccess, Function(String) onRegisterError) {
    _fireBaseAuth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((user) {
          print(user);
      _createUser(user.user!.uid, name, passcomfirn, onSuccess, onRegisterError);
    }).catchError((err) {
      print("err: " + err.toString());
      _onSignUpErr(err.code, onRegisterError);
    });
  }

  signIn(String email, String pass, Function onSuccess,
      Function(String) onSignInError) async {
    _fireBaseAuth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((user) {
      onSuccess();
    }).catchError((err) {
      print("err: " + err.toString());
      _onLogninErr(err.code, onSignInError);
    });
  }

  _createUser(String userId, String name, String passcomfirn, Function onSuccess,
      Function(String) onRegisterError) {
    var user = {
      "name" : name,
      "password" : passcomfirn,
    };

    // ignore: deprecated_member_use
    var ref = FirebaseDatabase.instance.reference().child("users");
    ref.child(userId).set(user).then((user) {
      print("on value: SUCCESSED");
      onSuccess();
    }).catchError((err) {
      print("err: " + err.toString());
      onRegisterError("SignUp fail, please try again" + err.toString());
    }).whenComplete(() {
      print("completed");
    });
  }

  ///
  void _onLogninErr(String code, Function(String) onSignInError){
    print(code);
    switch(code){
      case "invalid-email":
        onSignInError("Invalid email");
        break;
      case "wrong-password":
        onSignInError("Incorrect password");
        break;
      case "user-not-found":
        onSignInError("Account does not exist or has been deleted");
        break;
    }
  }
  void _onSignUpErr(String code, Function(String) onRegisterError) {
    print(code);
    switch (code) {
      case "invalid-email":
      case "invalid-credential":
        onRegisterError("Invalid email");
        break;
      case "email-already-in-use":
        onRegisterError("Email has existed");
        break;
      case "weak-password":
        onRegisterError("The password is not strong enough");
        break;
      default:
        onRegisterError("SignUp fail, please try again");
        break;
    }
  }

  Future<void> signOut() async {
    print("signOut");
    return _fireBaseAuth.signOut();
  }
}
