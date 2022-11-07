import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'load_msg_dilog.dart';
import 'package:profile/profile.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:app/view/GenerateQR.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
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
  final Stream<QuerySnapshot> user_profile =
  FirebaseFirestore.instance.collection('User_Profile').snapshots();

  void content() {
    setState(() {
      if (phonecontroller.text.length < 9 ||
          !phonecontroller.text.contains("0")) {
        _phoneInvalid = true;
      } else {
        _phoneInvalid = false;
      }
      if (teamscontroller.text.length < 5 ||
          !teamscontroller.text.contains('@')) {
        _teamsInvalid = true;
      } else {
        _teamsInvalid = false;
      }
      if (fbcontroller.text.length < 5 ||
          !fbcontroller.text.contains('facebook.com')) {
        _fbInvalid = true;
      } else {
        _fbInvalid = false;
      }
      if (istacontroller.text.length < 5 ||
          !istacontroller.text.contains('instagram.com')) {
        _instaInvalid = true;
      } else {
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

  CollectionReference profile =
  FirebaseFirestore.instance.collection("User_Profile");

  @override
  Widget build(BuildContext context) {
    double  heightR,widthR;
    heightR = MediaQuery.of(context).size.height / 1080; //v26
    widthR = MediaQuery.of(context).size.width / 2400;
    var curR = widthR;
    final User? user =
        auth.currentUser; // push user info to firebase when they update status
    final uid = user?.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text('Your personal profile'),
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
        child: FutureBuilder<DocumentSnapshot>(
            future: profile.doc(uid).get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              if (snapshot.hasData && !snapshot.data!.exists) {
                return  Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50*heightR,
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.fromLTRB(55*heightR, 260*widthR, 55*heightR, 260*widthR),
                        child: Text('Create or change your personal profile. We will generate your own QR code from your profile',style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
                      ),
                      SizedBox(
                        height: 20*heightR,
                      ),
                      Container(
                        margin: EdgeInsets.all(22*heightR),
                        child: _entryField(false, 'Insert your Phone Number',
                            phonecontroller, _phoneInvalid, _phoneError),
                      ),
                      Container(
                        margin: EdgeInsets.all(20*heightR),
                        child: _entryField(false, 'Insert your MS Teams account',
                            teamscontroller, _teamsInvalid, _teamsError),
                      ),
                      Container(
                        margin: EdgeInsets.all(22*heightR),
                        child: _entryField(false, 'Insert your Facebook URL',
                            fbcontroller, _fbInvalid, _fbError),
                      ),
                      Container(
                        margin: EdgeInsets.all(22*heightR),
                        child: _entryField(false, 'Insert your Instagram URL',
                            istacontroller, _instaInvalid, _instaError),
                      ),
                      Container(
                          height: 80*heightR,
                          margin: EdgeInsets.only(top: 70*heightR),
                          padding:  EdgeInsets.fromLTRB(120*curR, 0, 120*curR, 0),
                          child: ElevatedButton(
                            child:  Text(
                              'Save your profile',
                              style: TextStyle(fontSize: 120*curR),
                            ),
                            onPressed: () {
                              content();
                              if (_fbInvalid == false &&
                                  _instaInvalid == false &&
                                  _phoneInvalid == false &&
                                  _teamsInvalid == false &&
                                  already_saved == false) {
                                profile.doc(uid.toString()).set({
                                  'Phone Number': phonecontroller.text,
                                  'MS Teams': teamscontroller.text,
                                  'Facebook URL': fbcontroller.text,
                                  'Instagram URL': istacontroller.text,
                                  'ID': uid,
                                })
                                //.then((value) => print('ID:${uid}'))
                                    .catchError((error) =>
                                    print('Faild to add user: $error'));
                                already_saved = true;
                                AwesomeDialog(
                                  context: context,
                                  animType: AnimType.leftSlide,
                                  headerAnimationLoop: false,
                                  dialogType: DialogType.success,
                                  showCloseIcon: true,
                                  title: 'Successfully save profile',
                                  desc:
                                  'Congratulations!\nYour profile has been saved and personal QR is now available!',
                                  btnOkOnPress: () {
                                  },
                                  btnOkIcon: Icons.check_circle,
                                  onDismissCallback: (type) {
                                  },
                                ).show();
                              } else if (already_saved == true) {
                                //content();
                                MsgDialog.showMsgDialog(
                                    context,
                                    "Failed to create QR",
                                    "You have already created your QR");
                              }
                            },
                          )),
                    ],
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 40*heightR,
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding:  EdgeInsets.all(40.0*heightR),
                        child: Text('Your personal QR is ready!\nWe had generated personal QR from your profile.',
                            style: TextStyle(fontSize: 110*curR), textAlign: TextAlign.center),
                      ),
                      SizedBox(
                        height: 12*heightR,
                      ),
                      
                      Profile(
                        imageUrl: "https://scontent.fhan2-5.fna.fbcdn.net/v/t39.30808-6/256625965_2055617961261792_7247980732642938730_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=xH0qJA0PkR4AX-Mnt_x&_nc_ht=scontent.fhan2-5.fna&oh=00_AT-b5ApATd0KAGRJvfL0PAweRoIOj3RznRvOtrHAuFlSNg&oe=63459624",
                        name: data['Instagram URL'],
                        website: "",
                        designation: data['Facebook URL'],
                        email: data['MS Teams'],
                        phone_number: data['Phone Number'],
                      ),
                      Container(
                          height: 78*heightR,
                          margin: EdgeInsets.only(top: 32*heightR),
                          padding: EdgeInsets.fromLTRB(180*widthR, 0, 180*widthR, 0),
                          child: ElevatedButton(
                            child:  Text(
                              'Re-create your profile',
                              style: TextStyle(fontSize: 118*curR),
                            ),
                            onPressed: (){
                              AwesomeDialog(
                                context: context,
                                keyboardAware: true,
                                dismissOnBackKeyPress: false,
                                dialogType: DialogType.warning,
                                animType: AnimType.bottomSlide,
                                btnCancelText: "No, cancel",
                                btnOkText: "Yes, continue",
                                title: 'Continue re-creating your profile?',
                                // padding: const EdgeInsets.all(5.0),
                                desc:
                                'By re-creating your profile, your present profile and QR code will be deleted.\nOnce proceed, this can not be un-done and you must create a new profile for your personal QR code.\nPlease confirm that you want to proceed.',
                                btnCancelOnPress: () {},
                                btnOkOnPress: () {FirebaseFirestore.instance
                                    .collection("User_Profile")
                                    .doc(uid!)
                                    .delete();
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) => UserProfile()));},
                              ).show();
                            },
                          )),
                      Container(
                          height: 78*heightR,
                          margin: EdgeInsets.only(top: 32*heightR),
                          padding: EdgeInsets.fromLTRB(180*widthR, 0, 180*widthR, 0),
                          child: ElevatedButton(
                            child:  Text(
                              'Show your personal QR',
                              style: TextStyle(fontSize: 118*curR),
                            ),
                            onPressed: (){Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) => GenerateQRPage()));
                            },
                          )),
                    ],
                  ),
                );
              }

              return Text("loading");
            }),
      ),
    );
  }
}
