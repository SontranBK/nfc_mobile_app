import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:app/widgets/custom_appbar.dart';


const kLightBlue = Color(0xffEBF6FF);
const kDarkBlue = Color(0xff369FFF);


class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }


  @override
  Widget build(BuildContext context) {
    final List<String>title_name  = [
      "App Display Name",
      "App Package Name",
      "App Publish Version",
      "Release Build Number",
      "Release Build Signature",
      "Developing Teams",
    ];
    final List<String>content_name  = [
      _packageInfo.appName.isEmpty ? 'Not set' : _packageInfo.appName,
      "bklab-mana",
      "1.0.0",
      _packageInfo.buildNumber.isEmpty ? 'Not set' : _packageInfo.buildNumber,
      'Not set',
      "  Son Tran BK \n  and CTARG",
    ];

    return Scaffold(
      appBar: CustomAppbar(title: "App Information!"),
      body:Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Center(
      child: GridView.builder(
        itemCount: title_name.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 15,
            childAspectRatio: 1,
            crossAxisCount: 2,
            mainAxisSpacing: 40),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: kLightBlue,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title_name[index],
                    maxLines: 2,
                    softWrap: true,
                    style: const TextStyle(
                      fontSize: 17,
                      color: Color(0xff8EA3B7),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 35,
                        width: 8,
                        decoration: BoxDecoration(
                            color: kDarkBlue,
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      Text(
                        content_name[index],
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff006ED3),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    )
      )
    );
  }
}

