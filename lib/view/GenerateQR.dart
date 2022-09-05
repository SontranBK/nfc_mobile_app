import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQRCode extends StatefulWidget {
  const GenerateQRCode({Key? key}) : super(key: key);
  @override
  _GenerateQRCodeState createState() => _GenerateQRCodeState();
}

class _GenerateQRCodeState extends State<GenerateQRCode> {
  TextEditingController urlController = TextEditingController();

  ///String qrData="https://github.com/ChinmayMunje";
  ///final qrdataFeed = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Generate QR Code'),),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if(urlController.text.isNotEmpty)
                  QrImage(data: urlController.text,size: 200,),

                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.only(left:10, right: 10),
                  child: TextField(
                    controller: urlController,
                    decoration: InputDecoration(
                        hintText: 'Enter your data',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                        labelText: 'Enter your data'
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                ElevatedButton(onPressed: (){}, child: Text('Generate QR Code')),
              ],
            ),
          ),
        )
    );
  }
}
