import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQRPage extends StatefulWidget {
  @override
  _GenerateQRPageState createState() => _GenerateQRPageState();
}
class _GenerateQRPageState extends State<GenerateQRPage> {
  TextEditingController controller = TextEditingController();
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
                data: controller.text,
                size: 300,
                embeddedImage: AssetImage('images/logo.png'),
                embeddedImageStyle: QrEmbeddedImageStyle(
                    size: Size(80,80)
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey, width: 0.0),), 
                      labelText: 'Enter URL'
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
