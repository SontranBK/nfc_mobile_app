import 'package:app/view/common/form_row.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app/view/ScanQR.dart';
import 'package:flutter/services.dart';

class LinkPage extends StatelessWidget {
  LinkPage({Key? key, required this.qrResult}) : super(key: key);
  List<String> content = [];
  String qrResult;
  String content1 = '', content2 = '', content3 = '', content4 = '';

  void decodeQR()
  {
    String separator = " | ";
    int max = 0;
    while (true)
    {
      var index = qrResult.indexOf(" | ", 0);
      if (index == -1 || (max > 0 && content.length >= max)) {
        content.add(qrResult);
        break;
      }

      content.add(qrResult.substring(0, index));
      qrResult = qrResult.substring(index + separator.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    decodeQR();
    if(content[0] =="BKLAB"){
      content1 = content[1];
      content2 = content[2];
      content3 = content[3];
      content4 = content[4];
    }
    //print(content[0]);
      return Scaffold(
        appBar: AppBar(
          title: Text('QR Code Info'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.perm_device_information,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
              },
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: ListView(
          padding: EdgeInsets.all(2),
          children: [
            SizedBox(height: 50,),
            Center(
              child: Text('  Please copy phone number, MS Teams account\n  Or direct to Facebook, Instagram', style: TextStyle(fontSize: 20,color: Colors.black),),
            ),
            SizedBox(height: 30,),
            FormSection(children: [
              Container(),
              FormRow(
                  title: Text('Phone Number'),
                  trailing: Icon(Icons.content_copy),
                  onTap: () async {
                    await Clipboard.setData(ClipboardData(text: content1)).then((_){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Copy Phone Number: " + content1)));
                    });
                    // copied successfully
                  },

                  /*=>
                      launch('tel:+${content[1].toString()}')//('https://nfcmanager.naokiokada.com/privacy-policy/'),*/
              ),
              FormRow(
                  title: Text('Ms Teams'),
                  trailing: Icon(Icons.content_copy),
                  onTap: () async {
                    await Clipboard.setData(ClipboardData(text: content2)).then((_){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Copy Ms Teams: " + content2)));
                    });
                    // copied successfully
                  },
                  //=> launch("https://"+ content2)
              ),
              FormRow(
                  title: Text('Facebook'),
                  trailing: Icon(Icons.open_in_new),
                  onTap: () => launch(content3)
              ),
              FormRow(
                  title: Text('Instagram'),
                  trailing: Icon(Icons.open_in_new),
                  onTap: () => launch(content4)
              ),
            ]),
          ],
        ),
      );
  }
}

