import 'dart:async';

import 'package:app/view/fire_base_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthBloc {
  var _firAuth = FirAuth();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  StreamController _nameController = new StreamController();
  StreamController _emailController = new StreamController();
  StreamController _passController = new StreamController();
  StreamController _passcomfirnController = new StreamController();

  Stream get nameStream => _nameController.stream;

  Stream get emailStream => _emailController.stream;

  Stream get passStream => _passController.stream;

  Stream get passcomfirnStream => _passcomfirnController.stream;

  // bool isValid(String name, String email, String pass, String passcomfirn) {
  //   if (name == null || name.length == 0) {
  //     _nameController.sink.addError("Nhập tên");
  //     return false;
  //   }
  //   _nameController.sink.add("");
  //
  //   if (passcomfirn == null || passcomfirn.length < 6) {
  //     _passcomfirnController.sink.addError("Mật khẩu phải trên 5 ký tự");
  //     return false;
  //   }
  //   _passcomfirnController.sink.add("");
  //
  //   if (email == null || email.length == 0) {
  //     _emailController.sink.addError("Nhập email");
  //     return false;
  //   }
  //   _emailController.sink.add("");
  //
  //   if (pass == null || pass.length < 6) {
  //     _passController.sink.addError("Mật khẩu phải trên 5 ký tự");
  //     return false;
  //   }
  //   _passController.sink.add("");
  //
  //   return true;
  // }

  void signUp(String email, String pass, String passcomfirn, String name,
      Function onSuccess, Function(String) onError) {
    _firAuth.signUp(email, pass, name, passcomfirn, onSuccess, onError);
  }

  void signIn(String email, String pass, Function onSuccess,
      Function(String) onSignInError) {
    _firAuth.signIn(email, pass, onSuccess, onSignInError);
  }

  void dispose() {
    _nameController.close();
    _emailController.close();
    _passController.close();
    _passcomfirnController.close();
  }
}