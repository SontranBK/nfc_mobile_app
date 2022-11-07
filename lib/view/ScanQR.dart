import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
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
  String Thuc = "";
  String qrResult = ""; // store QR scanned result
  String showResult =
      "Please perform QR code scanning!"; // store message showing in top
  bool finished_scanCheckin = false; // if user finish scan QR for checking in
  bool finished_scanInfo = false; // if user finish scan QR for info
  bool Scan = false; // if user already update their status
  bool already_checkOut = false;
  bool already_updateStatus = false;
  bool finished_scanCheckout = false; // If user leaves, will scan QR to check out
  CollectionReference users = FirebaseFirestore.instance.collection("users");

  void _show_Success_Noti() {
    final User? user =
        auth.currentUser; // push user info to firebase when they update status
    final uid = user?.uid; // push user info to firebase when they update status
    String success_noti_message = ""; // use in success dialog
    String success_noti_title = ""; // use in success dialog
    DateTime now = DateTime.now();
    bool valid_checkin = true; // if user check in between 6am and 8pm
    String formattedDate = ""; // for
    if (!mounted) return;
    // Từ dòng 45-49 dòng code giúp lệnh true false được thực hiện ngay mà không cần ấn nút resets
    setState(() {
      this.Thuc = DateFormat('hh:mm:ss').format(now) +
          " a.m, " +
          DateFormat('dd MMM yyyy').format(now);
      print(Thuc);
    });
    if (8 < now.hour && now.hour < 13) {
      formattedDate = DateFormat('hh:mm:ss').format(now) +
          " a.m, " +
          DateFormat('dd MMM yyyy').format(now);
    } else {
      formattedDate = DateFormat('hh:mm:ss').format(now) +
          " p.m, " +
          DateFormat('dd MMM yyyy').format(now);
    }

    String today = DateFormat('dd MMM yyyy').format(now);
    if (8 < now.hour && now.hour < 18) {
      if (!already_updateStatus) {
        success_noti_message = 'You successfully checked in at ' +
            formattedDate +
            '.\nNow other LAB members will see your status as ONLINE until 18 p.m today !!!';
        success_noti_title = 'Congrats and welcome!';
        valid_checkin = true;
        already_checkOut = false;
        already_updateStatus = true;
        users.add({
          'ID người dùng': uid,
          'Email': user?.email,
          'Time': formattedDate,
          'Day': today,
          'Status': "Online"
        })
        //.then((value) => print('ID add: ${uid}' + 'Email add: ${user?.email}' + 'Time: $formattedDate'))
            .catchError((error) => print('Faild to add user: $error'));
      } else {
        success_noti_message =
        'You already checked in and updated your status as ONLINE.\nPlease check out to update your status again!';
        success_noti_title = 'Status updated already!';
        valid_checkin = true;
      }
    } else {
      success_noti_message = 'You checked in at ' +
          formattedDate +
          '.\nYou did not check in between 8 a.m and 6 p.m, therefore your status remains OFFLINE !!!';
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
      title: success_noti_title,
      desc: success_noti_message,
      btnOkOnPress: () {},
      btnOkIcon: valid_checkin ? Icons.check_circle : Icons.cancel,
      btnOkColor: valid_checkin ? Colors.green : Colors.red,
      onDismissCallback: (type) {},
    ).show();
  }

  void _show_Check_Out() {
    final User? user =
        auth.currentUser; // push user info to firebase when they update status
    final uid = user?.uid; // push user info to firebase when they update status

    String success_noti_message = ""; // use in success dialog
    String success_noti_title = ""; // use in success dialog
    DateTime now = DateTime.now();
    bool valid_checkout = true; // if user check in between 6am and 8pm
    String formattedDate = ""; // for
    if (!mounted) return;
    // Từ dòng 125-129 dòng code giúp lệnh true false được thực hiện ngay mà không cần ấn nút resets
    setState(() {
      this.Thuc = DateFormat('hh:mm:ss').format(now) +
          " a.m, " +
          DateFormat('dd MMM yyyy').format(now);
      print(Thuc);
    });
    if (8 < now.hour && now.hour < 13) {
      formattedDate = DateFormat('hh:mm:ss').format(now) +
          " a.m, " +
          DateFormat('dd MMM yyyy').format(now);
    } else {
      formattedDate = DateFormat('hh:mm:ss').format(now) +
          " p.m, " +
          DateFormat('dd MMM yyyy').format(now);
    }

    String today = DateFormat('dd MMM yyyy').format(now);
    if (8 < now.hour && now.hour < 18) {
      if (!already_checkOut) {
        success_noti_message = 'You successfully checked out at ' +
            formattedDate +
            '.\nNow other LAB members will see your status as ONLINE until 18 p.m today !!!';
        success_noti_title = 'Congrats and welcome!';
        valid_checkout = true;
        already_checkOut = true;
        already_updateStatus = false;
        users.add({
          'ID người dùng': uid,
          'Email': user?.email,
          'Time': formattedDate,
          'Day': today,
          'Status': "Offline"
        })
        //.then((value) => print('ID add: ${uid}' + 'Email add: ${user?.email}' + 'Time: $formattedDate'))
            .catchError((error) => print('Faild to add user: $error'));
      } else {
        success_noti_message =
        'You already checked out and updated your status as OFFLINE.\nPlease check in to update your status again!';
        success_noti_title = 'Status checkout already!';
        valid_checkout = true;
      }
    } else {
      success_noti_message = 'You checked in at ' +
          formattedDate +
          '.\nYou did not check in between 8 a.m and 6 p.m, therefore your status remains OFFLINE !!!';
      success_noti_title = 'Your check-out is invalid!';
      valid_checkout = false;
    }
    // Do something
    //Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen(),);)
    AwesomeDialog(
      context: context,
      animType: AnimType.leftSlide,
      headerAnimationLoop: false,
      dialogType: valid_checkout ? DialogType.success : DialogType.error,
      showCloseIcon: true,
      title: success_noti_title,
      desc: success_noti_message,
      btnOkOnPress: () {},
      btnOkIcon: valid_checkout ? Icons.check_circle : Icons.cancel,
      btnOkColor: valid_checkout ? Colors.green : Colors.red,
      onDismissCallback: (type) {},
    ).show();
  }

  void _direct_QR_content(qrResult) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LinkPage(qrResult: qrResult),
        ));
  }

  Future<void> scanQR() async {
    // DateTime now = DateTime.now();
    String thuc = '';
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      FirebaseFirestore.instance
          .collection('QR')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          if (!mounted) return;
          // Sửa lỗi bằng cách đưa setState vào trong Firebase để khi quét thì sẽ hiển thị ngay lập tức.
          setState(() {
            this.qrResult = qrCode.toString();
            print(qrResult);
          });
          if (qrResult == doc["qrResult"].toString()) {
            // showResult = 'Welcome to CTARG, at 618 Ta Quang Buu Library.\nPlease update status to ONLINE if you haven\'t';
            showResult = doc["showResult"].toString();
            finished_scanCheckin = true;
            finished_scanCheckout = true;
            // Scan = true;
          } else if (qrResult.substring(0, 8) == "BKLAB | ") {
            showResult =
            'Successfully scan QR contact\nClick "Open contact" for more info';
            finished_scanInfo = true;
          } else {
            showResult =
            'Invalid QR code for BK Lab Manager\nPlease try another QR code';
          }
        });
      });

      // else if(qrResult == 'MAP_410_C9Building_HUST'){
      //   showResult = 'Welcome to MAP, at 410 C9 Building.\nPlease update status to ONLINE if you haven\'t';
      //   finished_scanCheckin = true;
      // }

    } on PlatformException {
      qrResult = 'Fail to read QR Code';
      showResult = 'Fail to read QR Code';
    }
    // FirebaseFirestore.instance
    //     .collection('QR')
    //     .get()
    //     .then((QuerySnapshot querySnapshot) {
    //   querySnapshot.docs.forEach((doc)  async {
    //     print(doc["qrResult"]);
    //     if(qrResult == doc["qrResult"]){
    //       show = doc["showResult"].toString();
    //       // Scan = true;
    //       finished_scanCheckin = true;
    //       finished_scanCheckout = true;
    //     }
    //     else if(qrResult.substring(0, 8) == "BKLAB | "){
    //       show = 'Successfully scan QR contact\nClick "Open contact" for more info';
    //       finished_scanInfo = true;
    //     }
    //     else{
    //       showResult = 'Invalid QR code for BK Lab Manager\nPlease try another QR code';
    //     }
    //
    //   });
    //   showResult = show;
    // });
  }
  getBody() {
    double heightR, widthR;
    heightR = MediaQuery.of(context).size.height / 1080; //v26
    widthR = MediaQuery.of(context).size.width / 2400;
    var curR = widthR;
    final User? user =
        auth.currentUser; // push user info to firebase when they update status
    final uid = user?.uid;
    // if(Scan){
    //   FirebaseFirestore.instance
    //       .collection('users')
    //       .get()
    //       .then((QuerySnapshot querySnapshot) {
    //     querySnapshot.docs.forEach((doc)  async {
    //       if(doc['ID người dùng'] == uid){
    //         if(doc["Status"] == "Offline"){
    //           finished_scanCheckin = true;
    //           finished_scanCheckout = false;
    //         }
    //         else{
    //           finished_scanCheckin = false;
    //           finished_scanCheckout = true;
    //         }
    //       }
    //     });
    //   });
    // }
    return SingleChildScrollView(
      child: Column(
        children: [
          // SizedBox(
          //   height: 25 * heightR,
          // ),
          Text(
            '$showResult',
            style: TextStyle(
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 250*widthR),
          getActions(),
          SizedBox(height: 170*widthR),
          getActions1(),
          // Row(
          //   children: [
          //
          //   ],
          // ),
        ],
      ),
    );
  }

  getActions() {
    double heightR, widthR;
    heightR = MediaQuery.of(context).size.height / 1080; //v26
    widthR = MediaQuery.of(context).size.width / 2400;
    var curR = widthR;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 120 * widthR,
        ),
        Expanded(
            child: GestureDetector(
              onTap: scanQR,
              child: Container(
                  width: double.infinity,
                  height: 240 * heightR,
                  padding: EdgeInsets.only(
                      top: 40 * heightR,
                      bottom: 15 * heightR,
                      left: 57 * widthR,
                      right: 57 * widthR),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(16 * heightR),
                        decoration:
                        BoxDecoration(shape: BoxShape.circle, color: secondary),
                        child: IconButton(
                          icon: Icon(Icons.qr_code),
                          iconSize: 208 * curR,
                          color: Colors.black,
                          onPressed: scanQR,
                        ),
                      ),
                      // SizedBox(height: 22 * heightR),
                      Container(
                        alignment: Alignment.topCenter,
                        margin: EdgeInsets.only(left:80*widthR, right: 80*widthR),
                        child: Text(
                          "Click For QR Scanning",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 100 * curR,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  )),
            )),
        // SizedBox(
        //   height: 40 * widthR,
        // ),
        SizedBox(
          width: 120 * widthR,
        ),
        Expanded(
            child: GestureDetector(
              onTap: finished_scanCheckin ? _show_Success_Noti : null,
              child: Container(
                  width: double.infinity,
                  height: 240 * heightR,
                  padding: EdgeInsets.only(
                      top: 40 * heightR,
                      bottom: 15 * heightR,
                      left: 57 * widthR,
                      right: 57 * widthR),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.tealAccent,
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(16 * heightR),
                        decoration:
                        BoxDecoration(shape: BoxShape.circle, color: secondary),
                        child: IconButton(
                          icon: Icon(Icons.badge),
                          iconSize: 208 * curR,
                          color: Colors.black,
                          onPressed:
                          finished_scanCheckin ? _show_Success_Noti : null,
                        ),
                      ),
                      SizedBox(height: 22 * heightR),
                      Container(
                        alignment: Alignment.topCenter,
                        margin: EdgeInsets.only(left:80*widthR, right: 80*widthR),
                        child: Text(
                          "Check in",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 100 * curR,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  )),
            )),
        SizedBox(
          width: 120 * widthR,
        ),
      ],
    );
  }

  // getActions2() {
  //
  //   double heightR, widthR;
  //   heightR = MediaQuery.of(context).size.height / 1080; //v26
  //   widthR = MediaQuery.of(context).size.width / 2400;
  //   var curR = widthR;
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //     children: [
  //       SizedBox(
  //         width: 160 * widthR,
  //       ),
  //       Expanded(
  //           child: GestureDetector(
  //         onTap: finished_scanCheckin ? _show_Success_Noti : null,
  //         child: Container(
  //             // width: double.infinity,
  //             height: 240 * heightR,
  //             padding: EdgeInsets.only(
  //                 top: 40 * heightR,
  //                 bottom: 15 * heightR,
  //                 left: 57 * widthR,
  //                 right: 57 * widthR),
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(20),
  //               color: light_pink,
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: Colors.grey.withOpacity(0.1),
  //                   spreadRadius: 1,
  //                   blurRadius: 1,
  //                   offset: Offset(1, 1), // changes position of shadow
  //                 ),
  //               ],
  //             ),
  //             child: Column(
  //               children: [
  //                 Container(
  //                   alignment: Alignment.center,
  //                   padding: EdgeInsets.all(16 * heightR),
  //                   decoration:
  //                       BoxDecoration(shape: BoxShape.circle, color: secondary),
  //                   child: IconButton(
  //                     icon: Icon(Icons.badge),
  //                     iconSize: 208 * curR,
  //                     color: Colors.black,
  //                     onPressed:
  //                         finished_scanCheckin ? _show_Success_Noti : null,
  //                   ),
  //                 ),
  //                 SizedBox(height: 22 * heightR),
  //                 Text(
  //                   "Update Your Status",
  //                   style: TextStyle(
  //                       color: Colors.black,
  //                       fontSize: 100 * curR,
  //                       fontWeight: FontWeight.w600),
  //                 )
  //               ],
  //             )),
  //       )),
  //       SizedBox(
  //         width: 160 * widthR,
  //       ),
  //     ],
  //   );
  // }

  getActions1() {
    double heightR, widthR;
    heightR = MediaQuery.of(context).size.height / 1080; //v26
    widthR = MediaQuery.of(context).size.width / 2400;
    var curR = widthR;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 120 * widthR,
        ),
        Expanded(
            child: GestureDetector(
              onTap: () {
                finished_scanInfo ? _direct_QR_content(qrResult) : null;
              },
              child: Container(
                  width: double.infinity,
                  height: 240 * heightR,
                  padding: EdgeInsets.only(
                      top: 40 * heightR,
                      bottom: 15 * heightR,
                      left: 57 * widthR,
                      right: 57 * widthR),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: purple,
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(16 * heightR),
                        decoration:
                        BoxDecoration(shape: BoxShape.circle, color: secondary),
                        child: IconButton(
                          icon: Icon(Icons.contact_mail),
                          iconSize: 208 * curR,
                          color: finished_scanInfo ? Colors.black : Colors.grey,
                          onPressed: () {
                            finished_scanInfo ? _direct_QR_content(qrResult) : null;
                          },
                        ),
                      ),
                      // SizedBox(height: 22 * heightR),
                      Container(
                        alignment: Alignment.topCenter,
                        margin: EdgeInsets.only(left:80*widthR, right: 80*widthR),
                        child: Text(
                          "Open Contact From QR",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 100 * curR,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,

                        ),
                      ),
                      // Text(
                      //   "Open Contact From QR",
                      //   style: TextStyle(
                      //       color: Colors.black,
                      //       fontSize: 100 * curR,
                      //       fontWeight: FontWeight.w600),
                      // )
                    ],
                  )),
            )),
        // SizedBox(
        //   width: 160 * widthR,
        // ),
        SizedBox(
          width: 120 * widthR,
        ),
        Expanded(
            child: GestureDetector(
              onTap: finished_scanCheckout ? _show_Check_Out : null,
              child: Container(
                  width: double.infinity,
                  height: 240 * heightR,
                  padding: EdgeInsets.only(
                      top: 40 * heightR,
                      bottom: 15 * heightR,
                      left: 57 * widthR,
                      right: 57 * widthR),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.red[200],
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(16 * heightR),
                        decoration:
                        BoxDecoration(shape: BoxShape.circle, color: secondary),
                        child: IconButton(
                          icon: Icon(Icons.badge),
                          iconSize: 208 * curR,
                          color: Colors.black,
                          onPressed: finished_scanCheckout ? _show_Check_Out : null,
                        ),
                      ),
                      // SizedBox(height: 22 * heightR),
                      Container(
                        alignment: Alignment.topCenter,
                        margin: EdgeInsets.only(left:80*widthR, right: 80*widthR),
                        child: Text(
                          "Check Out",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 100 * curR,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      // Text(
                      //   "Check Out",
                      //   style: TextStyle(
                      //       color: Colors.black,
                      //       fontSize: 100 * curR,
                      //       fontWeight: FontWeight.w600),
                      // )
                    ],
                  )),
            )),
        SizedBox(
          width: 120 * widthR,
        ),
      ],
    );
  }

  // getActions4() {
  //   double heightR, widthR;
  //   heightR = MediaQuery.of(context).size.height / 1080; //v26
  //   widthR = MediaQuery.of(context).size.width / 2400;
  //   var curR = widthR;
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //     children: [
  //       SizedBox(
  //         width: 160 * widthR,
  //       ),
  //       Expanded(
  //           child: GestureDetector(
  //         onTap: finished_scanCheckout ? _show_Check_Out : null,
  //         child: Container(
  //             // width: double.infinity,
  //             height: 240 * heightR,
  //             padding: EdgeInsets.only(
  //                 top: 40 * heightR,
  //                 bottom: 15 * heightR,
  //                 left: 57 * widthR,
  //                 right: 57 * widthR),
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(20),
  //               color: light_pink,
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: Colors.grey.withOpacity(0.1),
  //                   spreadRadius: 1,
  //                   blurRadius: 1,
  //                   offset: Offset(1, 1), // changes position of shadow
  //                 ),
  //               ],
  //             ),
  //             child: Column(
  //               children: [
  //                 Container(
  //                   alignment: Alignment.center,
  //                   padding: EdgeInsets.all(16 * heightR),
  //                   decoration:
  //                       BoxDecoration(shape: BoxShape.circle, color: secondary),
  //                   child: IconButton(
  //                     icon: Icon(Icons.badge),
  //                     iconSize: 208 * curR,
  //                     color: Colors.black,
  //                     onPressed: finished_scanCheckout ? _show_Check_Out : null,
  //                   ),
  //                 ),
  //                 SizedBox(height: 22 * heightR),
  //                 Text(
  //                   "Check Out",
  //                   style: TextStyle(
  //                       color: Colors.black,
  //                       fontSize: 100 * curR,
  //                       fontWeight: FontWeight.w600),
  //                 )
  //               ],
  //             )),
  //       )),
  //       SizedBox(
  //         width: 160 * widthR,
  //       ),
  //     ],
  //   );
  // }

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
