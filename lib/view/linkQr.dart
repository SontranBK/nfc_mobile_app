import 'package:app/view/common/form_row.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app/view/ScanQR.dart';
import 'package:flutter/services.dart';
import 'package:profile/profile.dart';

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
    double  heightR,widthR;
    heightR = MediaQuery.of(context).size.height / 1080; //v26
    widthR = MediaQuery.of(context).size.width / 2400;
    var curR = widthR;
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
          padding: EdgeInsets.all(4*heightR),
          children: [
            SizedBox(height: 22*heightR,),
            Profile(
              imageUrl: "https://res.cloudinary.com/teepublic/image/private/s--WlHDkW0o--/t_Preview/b_rgb:0195c3,c_lpad,f_jpg,h_630,q_90,w_1200/v1570281377/production/designs/6215195_0.jpg",
              name: content3,
              website: "",
              designation: content4,
              email: content2,
              phone_number: content1,
            ),
            Container(
              alignment: Alignment.center,
              padding:  EdgeInsets.fromLTRB(240*curR, 30*heightR, 240*curR, 40*heightR),
              child: Text('You can copy phone number, MS Teams account, or open Facebook and Instagram page with buttons below',style: TextStyle(fontSize: 14), textAlign: TextAlign.center),
            ),
            FormSection(children: [
              Container(),
              FormRow(
                  title: Text('Copy Phone Number'),
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
                  title: Text('Copy MS Teams Account'),
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
                  title: Text('Open Facebook Profile'),
                  trailing: Icon(Icons.open_in_new),
                  onTap: () => launch(content3)
              ),
              FormRow(
                  title: Text('Open Instagram Profile'),
                  trailing: Icon(Icons.open_in_new),
                  onTap: () => launch(content4)
              ),
            ]),
          ],
        ),
      );
  }
}

