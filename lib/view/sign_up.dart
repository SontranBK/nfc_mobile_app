import 'package:app/view/home.dart';
import 'package:app/view/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'load_msg_dilog.dart';
import 'auth_bloc.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  AuthBloc authBloc = new AuthBloc();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _passcomfirnController = TextEditingController();

  @override
  void dispose(){
    authBloc.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double  heightR,widthR;
    heightR = MediaQuery.of(context).size.height / 1080; //v26
    widthR = MediaQuery.of(context).size.width / 2400;
    var curR = widthR;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
          padding:  EdgeInsets.all(65*curR),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding:  EdgeInsets.all(60*curR),
                  margin: EdgeInsets.only(top: 300*curR),
                  child:  Text(
                    'Create new account',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 185*curR),
                  )),
              Container(
                  alignment: Alignment.center,
                  padding:  EdgeInsets.all(40*curR),
                  margin: EdgeInsets.only(bottom: 120*heightR,top: 15*heightR),
                  child:  Text(
                    'Lets help you in completing your tasks!',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 110*curR),
                  )),
              Container(
                padding:  EdgeInsets.fromLTRB(40*widthR, 40*heightR, 40*widthR, 0),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      // borderSide:
                      // BorderSide(width: 3, color: Colors.greenAccent), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: 'Full Name',
                  ),
                ),
              ),
              Container(
                padding:  EdgeInsets.fromLTRB(40*widthR, 40*heightR, 40*widthR, 0),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      // borderSide:
                      // BorderSide(width: 3, color: Colors.greenAccent), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: 'User Name',
                  ),
                ),
              ),
              Container(
                padding:  EdgeInsets.fromLTRB(40*widthR, 40*heightR, 40*widthR, 0),
                child: TextField(
                  obscureText: true,
                  controller: _passController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      // borderSide:
                      // BorderSide(width: 3, color: Colors.greenAccent), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: 'Password',
                  ),
                ),
              ),
              Container(
                padding:  EdgeInsets.fromLTRB(40*widthR, 40*heightR, 40*widthR, 0),
                child: TextField(
                  obscureText: true,
                  controller: _passcomfirnController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      // borderSide:
                      // BorderSide(width: 3, color: Colors.greenAccent), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: 'Confirm Password',
                  ),
                ),
              ),

              Container(
                  height: 90*heightR,
                  margin: EdgeInsets.only(top: 70*heightR),
                  padding:  EdgeInsets.fromLTRB(40*curR, 0, 40*curR, 0),
                  child: ElevatedButton(
                    child:  Text(
                      'Register',
                      style: TextStyle(fontSize: 150*curR),
                    ),
                    onPressed: () {
                      if(_passController.text == _passcomfirnController.text){
                        _onSignUpClicked();
                      }
                      else{
                        MsgDialog.showMsgDialog(context, "Sign-Up", "Confirm password is incorrect");
                      }
                        print(_nameController.text);
                        print(_emailController.text);
                        print(_passController.text);
                        print(_passcomfirnController.text);
                    },
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                   Container(
                     margin: EdgeInsets.only(left: 200*widthR),
                     child: Text('Already have an account?',
                       style: TextStyle(
                         fontSize: 105*curR,
                       ),),
                   ),
                  Container(
                      margin: EdgeInsets.only(right: 200*widthR),
                      child: TextButton(
                      child:  Text(
                        'Sign in',
                        style: TextStyle(fontSize: 110*curR),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => SignPage(),
                        ));
                      },
                    )
                  )
                ],
              ),
            ],
          )),
    );

  }
  _onSignUpClicked() {
    // var isValid = authBloc.isValid(_nameController.text, _emailController.text,
    //     _passController.text, _passcomfirnController.text);
    // if (isValid) {
      // create user
      // loading dialog
      // LoadingDialog.showLoadingDialog(context, 'Loading...');
      authBloc.signUp(_emailController.text, _passController.text,
          _passcomfirnController.text, _nameController.text, () {
            // LoadingDialog.hideLoadingDialog(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LogInPage()));
          }, (msg) {
            // LoadingDialog.hideLoadingDialog(context);
            MsgDialog.showMsgDialog(context, "Sign-Up", msg);
            // show msg dialog
          });
    }
  // }
}
