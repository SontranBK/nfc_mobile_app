import 'package:app/view/login.dart';
import 'package:app/theme/colors.dart';
import 'package:app/widgets/action_box.dart';
import 'package:app/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app/view/empty_page.dart';
import 'package:app/view/change_password.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({ Key? key }) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: secondary,
        appBar: CustomAppbar(title: "App Setting!"),
        body: getBody(),
      );
  }

  getBody(){
    return
      SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40,),
            getActions(),
            SizedBox(height: 40,),
            getActions2(),
            SizedBox(height: 40,),
            getActions3(),

          ],
        ),
      );
  }

  getActions(){
    return
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width: 30,),
          Expanded(
              child: ActionBox(title: "Sign Out", icon: Icons.login, bgColor: green, linkscreen: LogInPage())
          ),
          SizedBox(width: 30,),
        ],
      );
  }

  getActions2(){
    return
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width: 30,),
          Expanded(
              child: GestureDetector(
                onTap: () => launch('https://forms.gle/js5fdh2H4F7HHw4MA'),
                child: Container(
                  // width: double.infinity,
                    height: 160,
                    padding: EdgeInsets.only(top: 20, bottom: 14, left: 7, right: 7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: purple,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(1, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: secondary
                          ),
                          child: IconButton(
                            icon: Icon(Icons.rate_review),
                            iconSize: 38,
                            color: Colors.black,
                            onPressed:() => launch('https://forms.gle/js5fdh2H4F7HHw4MA'),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text("Leave Us Feedback", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),)
                      ],
                    )
                ),
              )
          ),
          SizedBox(width: 30,),
        ],
      );
  }

  getActions3(){
    return
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width: 30,),
          Expanded(
              child: ActionBox(title: "Change Your Password", icon: Icons.key, bgColor: yellow, linkscreen: ChagePasswordPage())
          ),
          SizedBox(width: 30,),
        ],
      );
  }

}