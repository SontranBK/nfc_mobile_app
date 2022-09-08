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
        title: Text('QR GENERATOR'),
      ),
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
                      border: OutlineInputBorder(), labelText: 'Enter URL'),
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
/*class GenerateQRCode extends StatefulWidget {
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
                  ///QrImage(data: urlController.text,size: 200,),
                  QrImage(
                    data: 'This QR code will show the error state instead',
                    version: 1,
                    size: 320,
                    gapless: false,
                    errorStateBuilder: (cxt, err) {
                      return Container(
                        child: Center(
                          child: Text(
                            "Uh oh! Something went wrong...",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                  ),
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
}*/