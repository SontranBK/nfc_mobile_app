import 'package:flutter/material.dart';
import 'package:app/widgets/custom_appbar.dart';


const kLightBlue = Color(0xffEBF6FF);
const kDarkBlue = Color(0xff369FFF);


class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  @override
  Widget build(BuildContext context) {
    double  heightR,widthR;
    heightR = MediaQuery.of(context).size.height / 1080; //v26
    widthR = MediaQuery.of(context).size.width / 2400;
    var curR = widthR;
    final List<String>title_name  = [
      "App Display Name",
      "App Package Name",
      "App Publish Version",
      "Release Build Number",
      "Release Build Signature",
      "Developing Teams",
    ];
    final List<String>content_name  = [
      "BK Lab Manager",
      "bklab-mana",
      "1.2.0",
      "2",
      'Not set',
      "  Son Tran BK \n  and CTARG",
    ];

    return Scaffold(
      appBar: CustomAppbar(title: "App Information!"),
      body:Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20.0 * heightR),
      child: Center(
      child: GridView.builder(
        itemCount: title_name.length,
        //physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 15*heightR,
            childAspectRatio: 1.35*heightR,
            crossAxisCount: 2,
            mainAxisSpacing: 40*heightR),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: kLightBlue,
            ),
            child: Padding(
              padding:  EdgeInsets.symmetric(
                  horizontal: 80*curR,
                  vertical: 120*curR),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title_name[index],
                    maxLines: 2,
                    softWrap: true,
                    style:  TextStyle(
                      fontSize: 120*curR,
                      color: Color(0xff8EA3B7),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 45*heightR,
                        width: 48*curR,
                        decoration: BoxDecoration(
                            color: kDarkBlue,
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      Text(
                        content_name[index],
                        style:  TextStyle(
                          fontSize: 72*curR,
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

