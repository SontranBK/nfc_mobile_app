import 'package:app/view/GenerateQR.dart';
import 'package:app/view/ScanQR.dart';
import 'package:app/view/login.dart';
import 'package:badges/badges.dart';
import 'package:app/data/json.dart';
import 'package:app/theme/colors.dart';
import 'package:app/widgets/action_box.dart';
import 'package:app/widgets/avatar_image.dart';
import 'package:app/widgets/balance_card.dart';
import 'package:app/widgets/transaction_item.dart';
import 'package:app/widgets/user_box.dart';
import 'package:flutter/material.dart';
import 'package:app/view/tag_read.dart';

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
        backgroundColor: Colors.transparent,
        //appBar: getAppBar(),
        body: getBody(),
      );
  }

  getAppBar(){
    return
      Container(
            height: 130,
            padding: EdgeInsets.only(left: 20, right: 20, top: 35),
            decoration: BoxDecoration(
              color: appBgColor,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
              boxShadow: [
                BoxShadow(
                  color: shadowColor.withOpacity(0.1),
                  blurRadius: .5,
                  spreadRadius: .5,
                  offset: Offset(0, 1)
                )
              ]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AvatarImage(profile, isSVG: false, width: 35, height: 35),
                SizedBox(width: 15,),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    // color: Colors.red,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hello Sangvaleap,", style: TextStyle(color: Colors.grey, fontSize: 13),),
                        SizedBox(height: 5,),
                        Text("Welcome BK Lab!", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),),
                      ],
                    ),
                  )
                ),
                SizedBox(width: 15,),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(1, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  // child: Icon(Icons.notifications_rounded)
                  child: Badge(
                    padding: EdgeInsets.all(3),
                    position: BadgePosition.topEnd(top: -5, end: 2),
                    badgeContent: Text('', style: TextStyle(color: Colors.white),),
                    child: Icon(Icons.notifications_rounded)
                  ),
                ),
              ],
            ),
          );
  }

  getBody(){
    return
    SingleChildScrollView(
      child: Column(
        children: [
          getAppBar(),
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
          SizedBox(width: 15,),
          Expanded(
            child: ActionBox(title: "Read NFC", icon: Icons.nfc, bgColor: green, linkscreen: TagReadPage.withDependency())
          ),
          SizedBox(width: 15,),
          Expanded(
            child: ActionBox(title: "QR Scan", icon: Icons.qr_code_scanner, bgColor: yellow, linkscreen: ScanQRCode())
          ),
          SizedBox(width: 15,),
          Expanded(
            child: ActionBox(title: "Gen QR", icon: Icons.qr_code_2, bgColor: purple, linkscreen: GenerateQRPage())
          ),
          SizedBox(width: 15,),
        ],
      );
  }

  getActions2(){
    return
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width: 15,),
          Expanded(
              child: ActionBox(title: "Sign Out", icon: Icons.login, bgColor: green, linkscreen: LogInPage())
          ),
          SizedBox(width: 15,),
          Expanded(
              child: ActionBox(title: "User Profile", icon: Icons.person_add_alt, bgColor: yellow, linkscreen: ScanQRCode())
          ),
          SizedBox(width: 15,),
          Expanded(
              child: ActionBox(title: "Users Status", icon: Icons.person_outline, bgColor: purple, linkscreen: ScanQRCode())
          ),
          SizedBox(width: 15,),
        ],
      );
  }
}