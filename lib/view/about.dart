import 'package:app/view/common/form_row.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BK LAB manager informations'),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.all(2),
        children: [
          FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (context, ss) => FormSection(children: [
              FormRow(
                title: Text('App name'),
                trailing: Text(ss.data?.appName ?? ''),
              ),
              FormRow(
                title: Text('Version'),
                trailing: Text(ss.data?.version ?? ''),
              ),
              FormRow(
                title: Text('Build number'),
                trailing: Text(ss.data?.buildNumber ?? ''),
              ),
            ]),
          ),
          FormSection(children: [
            FormRow(
              title: Text('Policy'),
              trailing: Icon(Icons.open_in_new),
              onTap: () => launch('') //('https://nfcmanager.naokiokada.com/privacy-policy/'),
            ),
          ]),
        ],
      ),
    );
  }
}
