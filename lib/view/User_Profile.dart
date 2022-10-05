import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'load_msg_dilog.dart';

class UserProfile extends StatefulWidget{
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile>{
  final FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController phonecontroller = TextEditingController();
  TextEditingController teamscontroller = TextEditingController();
  TextEditingController fbcontroller = TextEditingController();
  TextEditingController istacontroller = TextEditingController();

  var _phoneInvalid = false;
  var _teamsInvalid = false;
  var _fbInvalid = false;
  var _instaInvalid = false;
  var _phoneError = "Inserted phone number is not valid";
  var _teamsError = "Inserted MS Teams account is not valid";
  var _fbError = "Inserted Facebook URL is not valid";
  var _instaError = "Inserted Instagram URL is not valid";

  bool already_saved = false;

  void content(){
    setState((){
      if(phonecontroller.text.length < 9 || !phonecontroller.text.contains("0")){
        _phoneInvalid = true;
      }else{
        _phoneInvalid = false;
      }
      if(teamscontroller.text.length < 5 || !teamscontroller.text.contains('@') ){
        _teamsInvalid = true;
      }else{
        _teamsInvalid = false;
      }
      if(fbcontroller.text.length < 5 || !fbcontroller.text.contains('facebook.com') ){
        _fbInvalid = true;
      }else {
        _fbInvalid = false;
      }
      if(istacontroller.text.length < 5 || !istacontroller.text.contains('instagram.com') ){
        _instaInvalid = true;
      }else {
        _instaInvalid = false;
      }
    });
  }
  Widget _entryField(
      bool obscure,
      String title,
      TextEditingController controller,
      var users,
      var error,
      ) {
    return TextField(
      obscureText: obscure,
      controller: controller,
      decoration: InputDecoration(
        errorText: users ? error : null,
        enabledBorder: OutlineInputBorder(
          // borderSide:
          // BorderSide(width: 3, color: Colors.greenAccent), //<-- SEE HERE
          borderRadius: BorderRadius.circular(20.0),
        ),
        labelText: title,
      ),
    );
  }
  CollectionReference profile = FirebaseFirestore.instance.collection("User_Profile");

  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser; // push user info to firebase when they update status
    final uid = user?.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text('Create your personal QR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.folder_shared,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 80,
              ),
              Container(
                  margin: EdgeInsets.all(20),
                  child: _entryField(false,'Insert your phone number', phonecontroller,_phoneInvalid,_phoneError)
              ),
              Container(
                  margin: EdgeInsets.all(20),
                  child: _entryField(false,'Insert your MS Teams account', teamscontroller,_teamsInvalid,_teamsError)
              ),
              Container(
                  margin: EdgeInsets.all(20),
                  child: _entryField(false,'Insert your Facebook URL', fbcontroller,_fbInvalid,_fbError)
              ),
              Container(
                  margin: EdgeInsets.all(20),
                  child: _entryField(false,'Insert your Instagram URL', istacontroller,_instaInvalid,_instaError)
              ),

              Container(
                  height: 60,
                  margin: EdgeInsets.only(top: 60),
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text(
                      'Save your profile',
                      style: TextStyle(fontSize: 24),
                    ),
                    onPressed: () {
                      content();
                      if(_fbInvalid == false &&_instaInvalid == false &&_phoneInvalid == false &&_teamsInvalid==false && already_saved == false){
                        profile.add({
                          'Phone Number': phonecontroller.text,
                          'MS Teams': teamscontroller.text,
                          'Facebook URL': fbcontroller.text,
                          'Instagram URL': istacontroller.text,
                          'ID': uid,
                        })
                            //.then((value) => print('ID:${uid}'))
                            .catchError(
                                (error) => print('Faild to add user: $error'));
                        already_saved = true;
                      }else if (already_saved == true){
                        //content();
                        MsgDialog.showMsgDialog(context, "Failed to create QR", "You have already created your QR");
                      }
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
  
}