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
  var _phoneInvalid = false;
  var _teamsInvalid = false;
  var _fbInvalid = false;
  var _instaInvalid = false;
  var _phoneError = "Inserted phone number is not valid";
  var _teamsError = "Inserted MS Teams account is not valid";
  var _fbError = "Inserted Facebook URL is not valid";
  var _instaError = "Inserted Instagram URL is not valid";


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
              ElevatedButton(
                  onPressed: () {
                    content();
                  },
                  child: Text('GENERATE QR')

              ),


            ],
          ),
        ),
      ),
    );
  }
}