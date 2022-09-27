import 'package:app/view/common/form_row.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app/view/ScanQR.dart';

class LinkPage extends StatelessWidget {
  LinkPage({Key? key, required this.qrResult}) : super(key: key);
  List<String> content = [];
  String qrResult;

  //String content1, content2, content3, content4;

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
    //print(content[0]);
    return Scaffold(
      appBar: AppBar(
        title: Text('BK LAB manager information'),
      ),
      body: ListView(
        padding: EdgeInsets.all(2),
        children: [
          FormSection(children: [
            FormRow(
                title: Text('Phone Number'),
                trailing: Icon(Icons.open_in_new),
                onTap: () => launch(content[1]) //('https://nfcmanager.naokiokada.com/privacy-policy/'),
            ),
            FormRow(
                title: Text('Ms Teams'),
                trailing: Icon(Icons.open_in_new),
                onTap: () => launch(content[1]) //('https://nfcmanager.naokiokada.com/privacy-policy/'),
            ),
            FormRow(
                title: Text('Facebook'),
                trailing: Icon(Icons.open_in_new),
                onTap: () => launch(content[2]) //('https://nfcmanager.naokiokada.com/privacy-policy/'),
            ),
            FormRow(
                title: Text('Instagram'),
                trailing: Icon(Icons.open_in_new),
                onTap: () => launch(content[3]) //('https://nfcmanager.naokiokada.com/privacy-policy/'),
            ),
          ]),
        ],
      ),
    );
  }
}

