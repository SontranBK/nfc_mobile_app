import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQRPage extends StatefulWidget {
  @override
  _GenerateQRPageState createState() => _GenerateQRPageState();
}
class _GenerateQRPageState extends State<GenerateQRPage> {
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController teamscontroller = TextEditingController();
  TextEditingController fbcontroller = TextEditingController();
  TextEditingController istacontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate your QR code'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.qr_code_2,
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
              QrImage(
                data: "BKLAB | " + phonecontroller.text + " | " + teamscontroller.text + " | " + fbcontroller.text + " | " + istacontroller.text,
                size: 300,
                embeddedImage: AssetImage('images/logo.png'),
                embeddedImageStyle: QrEmbeddedImageStyle(
                    size: Size(80,80)
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: TextField(
                  controller: phonecontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 0.0),),
                      labelText: 'Phone Number '
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: TextField(
                  controller: teamscontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 0.0),),
                      labelText: 'Ms Teams'
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: TextField(
                  controller: fbcontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 0.0),),
                      labelText: 'Facebook URL'
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: TextField(
                  controller: istacontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 0.0),),
                      labelText: 'Instagram URL'
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                    });
                  },
                  child: Text('GENERATE QR')),

            ],
          ),
        ),
      ),
    );
  }
}