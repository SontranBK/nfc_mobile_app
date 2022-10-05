import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:app/widgets/custom_appbar.dart';
import 'package:app/theme/colors.dart';
import 'package:app/view/linkQr.dart';

class ScanQRCode extends StatefulWidget {
  const ScanQRCode({Key? key}) : super(key: key);

  @override
  _ScanQRCodeState createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode> {

  final FirebaseAuth auth = FirebaseAuth.instance;
  String qrResult = ""; // store QR scanned result
  String showResult = "Please perform QR code scanning!"; // store message showing in top
  bool finished_scanCheckin = false; // if user finish scan QR for checking in
  bool finished_scanInfo = false; // if user finish scan QR for info
  bool already_updateStatus = false; // if user already update their status

  void _show_Success_Noti() {
    final User? user = auth.currentUser; // push user info to firebase when they update status
    final uid = user?.uid; // push user info to firebase when they update status

    String success_noti_message = ""; // use in success dialog
    String success_noti_title = ""; // use in success dialog
    DateTime now = DateTime.now();
    bool valid_checkin = true; // if user check in between 6am and 8pm
    String formattedDate = ""; // for

    if (8 < now.hour && now.hour < 13)
      {
        formattedDate = DateFormat('hh:mm:ss').format(now)+" a.m, "+DateFormat('dd MMM yyyy').format(now);
      }
    else {
      formattedDate = DateFormat('hh:mm:ss').format(now)+" p.m, "+DateFormat('dd MMM yyyy').format(now);
    }

    String today = DateFormat('dd MMM yyyy').format(now);
    if (8 < now.hour && now.hour < 18) {
      if (!already_updateStatus) {
        success_noti_message = 'You successfully checked in at ' + formattedDate +
            '.\nNow other LAB members will see your status as ONLINE until 18 p.m today !!!';
        success_noti_title = 'Congrats and welcome!';
        valid_checkin = true;
        already_updateStatus = true;
        users.add({'ID người dùng': uid,'Email':user?.email,'Time': formattedDate,'Day':today})
        //.then((value) => print('ID add: ${uid}' + 'Email add: ${user?.email}' + 'Time: $formattedDate'))
            .catchError(
                (error) => print('Faild to add user: $error'));
      }
      else{
        success_noti_message = 'You already checked in and updated your status as ONLINE.\nPlease do not update your status again!';
        success_noti_title = 'Status updated already!';
        valid_checkin = true;
      }
    }
    else {
      success_noti_message = 'You checked in at '+formattedDate+'.\nYou did not check in between 8 a.m and 6 p.m, therefore your status remains OFFLINE !!!';
      success_noti_title = 'Your check-in is invalid!';
      valid_checkin = false;
    }
    // Do something
    //Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen(),);)
    AwesomeDialog(
      context: context,
      animType: AnimType.leftSlide,
      headerAnimationLoop: false,
      dialogType: valid_checkin ? DialogType.success : DialogType.error,
      showCloseIcon: true,
      title:success_noti_title,
      desc:success_noti_message,
      btnOkOnPress: () {},
      btnOkIcon: valid_checkin ? Icons.check_circle : Icons.cancel,
      btnOkColor: valid_checkin ? Colors.green : Colors.red,
      onDismissCallback: (type) {},
    ).show();
  }
  CollectionReference users = FirebaseFirestore.instance.collection("users");

  void _direct_QR_content(qrResult){
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => LinkPage(qrResult: qrResult),
    ));
  }

  Future<void> scanQR() async {
    DateTime now = DateTime.now();
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      if (!mounted) return;
      setState(() {
        this.qrResult = qrCode.toString();
      });
      if(qrResult == 'LAB_CTARG_618_TaQuangBuuLibrary_HUST'){
        showResult = 'Welcome to CTARG, at 618 Ta Quang Buu Library.\nPlease update status to ONLINE if you haven\'t';
        finished_scanCheckin = true;
      }
      else if(qrResult == 'MAP_410_C9Building_HUST'){
        showResult = 'Welcome to MAP, at 410 C9 Building.\nPlease update status to ONLINE if you haven\'t';
        finished_scanCheckin = true;
      }
      else if(qrResult.substring(0, 8) == "BKLAB | "){
        showResult = 'Successfully scan QR contact\nClick "Open contact" for more info';
        finished_scanInfo = true;
      }
      else{
        showResult = 'Invalid QR code for BK Lab Manager\nPlease try another QR code';
      }
    } on PlatformException {
      qrResult = 'Fail to read QR Code';
      showResult = 'Fail to read QR Code';
    }
  }

  getBody(){
    return
      SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Text('$showResult', style: TextStyle(color: Colors.black),),
            SizedBox(height: 30,),
            getActions(),
            SizedBox(height: 30,),
            getActions2(),
            SizedBox(height: 30,),
            getActions3(),
            SizedBox(height: 30,),

          ],
        ),
      );
  }


  getActions(){
    return
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width: 30,),
          Expanded(
              child: GestureDetector(
                onTap: scanQR,
                child: Container(
                  // width: double.infinity,
                    height: 160,
                    padding: EdgeInsets.only(top: 20, bottom: 14, left: 7, right: 7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: yellow,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(1, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: secondary
                          ),
                          child: IconButton(
                            icon: Icon(Icons.qr_code),
                            iconSize: 38,
                            color: Colors.black,
                            onPressed: scanQR,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text("Click For QR Scanning", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),)
                      ],
                    )
                ),
              )
          ),
          SizedBox(width: 30,),
        ],
      );
  }

  getActions2(){
    return
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width: 30,),
          Expanded(
              child: GestureDetector(
                onTap: finished_scanCheckin ? _show_Success_Noti : null,
                child: Container(
                  // width: double.infinity,
                    height: 160,
                    padding: EdgeInsets.only(top: 20, bottom: 14, left: 7, right: 7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: light_pink,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(1, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: secondary
                          ),
                          child: IconButton(
                            icon: Icon(Icons.badge),
                            iconSize: 38,
                            color: Colors.black,
                            onPressed: finished_scanCheckin ? _show_Success_Noti : null,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text("Update Your Status", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),)
                      ],
                    )
                ),
              )
          ),
          SizedBox(width: 30,),
        ],
      );
  }

  getActions3(){
    return
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width: 30,),
          Expanded(
              child: GestureDetector(
                onTap: () {finished_scanInfo ? _direct_QR_content(qrResult) : null;
                },
                child: Container(
                  // width: double.infinity,
                    height: 160,
                    padding: EdgeInsets.only(top: 20, bottom: 14, left: 7, right: 7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: light_pink,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(1, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: secondary
                          ),
                          child: IconButton(
                            icon: Icon(Icons.contact_mail),
                            iconSize: 38,
                            color: finished_scanInfo? Colors.black : Colors.grey,
                            onPressed: () {finished_scanInfo ? _direct_QR_content(qrResult) : null;
                            },
                          ),
                        ),
                        SizedBox(height: 16),
                        Text("Open Contact From QR", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),)
                      ],
                    )
                ),
              )
          ),
          SizedBox(width: 30,),
        ],
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Scan QR for Information"),
      backgroundColor: Colors.white,
      body: Center(
        child: getBody(),
      ),
    );
  }
}