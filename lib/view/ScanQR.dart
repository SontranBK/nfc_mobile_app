import 'dart:io';
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

  String qrResult = "";
  bool finished_scanning = false;

  void _show_Success_Noti() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('hh:mm:ss, dd MMM yyyy').format(now);
    // Do something
    //Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen(),);)
    AwesomeDialog(
      context: context,
      animType: AnimType.leftSlide,
      headerAnimationLoop: false,
      dialogType: DialogType.success,
      showCloseIcon: true,
      title: 'Congrats and Welcome!',
      desc:
      'You successfully checked in at '+formattedDate+'.\nNow other LAB members will see your status as ONLINE until 18 p.m today !!!',
      btnOkOnPress: () {},
      btnOkIcon: Icons.check_circle,
      onDismissCallback: (type) {},
    ).show();
  }

  Future<void> scanQR() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      if (!mounted) return;
      setState(() {
        this.qrResult = qrCode.toString();
      });
      if(qrResult == 'LAB_CTARG_618_TaQuangBuuLibrary_HUST'){
        qrResult = 'Welcome to CTARG, at 618 Ta Quang Buu Library';
        finished_scanning = true;
      }
    } on PlatformException {
      qrResult = 'Fail to read QR Code';
    }
  }

  getBody(){
    return
      SingleChildScrollView(
        child: Column(
          children: [
            //Text('$qrResult', style: TextStyle(color: Colors.black),),
            SizedBox(height: 50,),
            getActions(),
            SizedBox(height: 50,),
            getActions2(),
            SizedBox(height: 50,),
            getActions3(),

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
                onTap: finished_scanning ? _show_Success_Noti : null,
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
                            onPressed: finished_scanning ? _show_Success_Noti : null,
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
                onTap: finished_scanning ? _show_Success_Noti : null,
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
                            icon: Icon(Icons.open_in_new),
                            iconSize: 38,
                            color: Colors.black,
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => LinkPage(qrResult: qrResult),
                              ));
                            },
                          ),
                        ),
                        SizedBox(height: 16),
                        Text("QR Content", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),)
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