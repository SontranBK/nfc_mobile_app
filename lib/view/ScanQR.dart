import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:intl/intl.dart';
import 'package:app/view/app.dart';
import 'package:provider/provider.dart';

class ScanQRCode extends StatefulWidget {
  const ScanQRCode({Key? key}) : super(key: key);

  @override
  _ScanQRCodeState createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode> {

  String qrResult = "Scanner Data will appear hear";
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('QR Code Scanner'),),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30,),
            Text('$qrResult', style: TextStyle(color: Colors.black),),
            SizedBox(height: 30,),
            ElevatedButton(onPressed: scanQR, child: Text('Scan Code')),
            SizedBox(height: 30,),
            ElevatedButton(onPressed: finished_scanning ? _show_Success_Noti : null, child: Text('Change Status')),
          ],
        ),
      ),
    );
  }
}