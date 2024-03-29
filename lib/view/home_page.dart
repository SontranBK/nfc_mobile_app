import 'package:app/view/GenerateQR.dart';
import 'package:app/view/ScanQR.dart';
import 'package:app/view/login.dart';
import 'package:app/theme/colors.dart';
import 'package:app/widgets/action_box.dart';
import 'package:app/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:app/view/tag_read.dart';
import 'package:app/view/empty_page.dart';
import 'package:app/view/User_Status.dart';
import 'package:app/view/User_Profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: secondary,
        appBar: CustomAppbar(title: "Welcome to BK Lab!"),
        body: getBody(),
      );
  }


  getBody(){
    return
      SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50,),
            getActions(),
            SizedBox(height: 50,),
            getActions2(),

          ],
        ),
      );
  }

  getActions(){
    return
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width: 25,),
          Expanded(
              child: ActionBox(title: "Read NFC", icon: Icons.nfc, bgColor: green, linkscreen: TagReadPage.withDependency())
          ),
          SizedBox(width: 35,),
          Expanded(
              child: ActionBox(title: "Gen QR", icon: Icons.qr_code_2, bgColor: purple, linkscreen: GenerateQRPage())
          ),
          SizedBox(width: 25,),
        ],
      );
  }

  getActions2(){
    return
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width: 25,),
          Expanded(
              child: ActionBox(title: "User Profile", icon: Icons.contact_page, bgColor: yellow, linkscreen: UserProfile())
          ),
          SizedBox(width: 25,),
          Expanded(
              child: ActionBox(title: "Users Status", icon: Icons.manage_accounts, bgColor: blue, linkscreen: UserStatusPage())
          ),
          SizedBox(width: 25,),
        ],
      );
  }
}