import 'package:app/view/home_page.dart';
import 'package:app/view/setting_page.dart';
import 'package:app/theme/colors.dart';
import 'package:app/view/ScanQR.dart';
import 'package:app/view/user_page.dart';
import 'package:app/view/about.dart';
import 'package:app/view/login.dart';
import 'package:app/view/sign_up.dart';
import 'package:app/widgets/bottombar_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:internet_popup/internet_popup.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int activeTab = 0;
  
  @override
  void initState() {
    super.initState();
    InternetPopup().initialize(context: context);
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: appBgColor.withOpacity(.95),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40), 
          topRight: Radius.circular(40)
        ), 
        ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: getBottomBar(),
        floatingActionButton: getHomeButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
        body: getBarPage()
      ),
    );
  }

  Widget getHomeButton(){
    double  heightR,widthR;
    heightR = MediaQuery.of(context).size.height / 1080; //v26
    widthR = MediaQuery.of(context).size.width / 2400;
    var curR = widthR;
    return Container(
      margin: EdgeInsets.only(top: 28*heightR),
      // padding: EdgeInsets.all(30*heightR),
      child: GestureDetector(
        onTap: () {
          setState(() {
            activeTab= 2;
          });
        },
        child: Container(
            padding: EdgeInsets.all(60*curR),
            decoration: BoxDecoration(
              border: Border.all(
                color: primary,
              ),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: primary,
              //shape: BoxShape.circle,
            ),
            child: Icon(Icons.qr_code_scanner,
              color: Colors.white,
              size: 280*curR,),
          ),
      ),
    );
  }

  Widget getBottomBar() {
    double  heightR,widthR;
    heightR = MediaQuery.of(context).size.height / 1080; //v26
    widthR = MediaQuery.of(context).size.width / 2400;
    var curR = widthR;
    return Container(
      height: 128*heightR,
      width: double.infinity,
      decoration: BoxDecoration(
        color: bottomBarColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25), 
          topRight: Radius.circular(25)
        ), 
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.1),
            blurRadius: .5,
            spreadRadius: .5,
            offset: Offset(0, 1)
          )
        ]
      ),
      child: Padding(
        padding:  EdgeInsets.only(left: 125*widthR, right: 125*widthR,top: 10*heightR),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BottomBarItem(
                Icons.home_rounded,
                "Home",
                isActive: activeTab == 0,
                activeColor: primary,
                onTap: () {
                  setState(() {
                    activeTab = 0;
                  });
                },
              ),
              BottomBarItem(
                Icons.person_rounded,
                "Users",
                isActive: activeTab == 1,
                activeColor: primary,
                onTap: () {
                  setState(() {
                    activeTab = 1;
                  });
                },
              ),
              BottomBarItem(
                Icons.qr_code_scanner,
                "QR Code",
                isActive: activeTab == 2,
                activeColor: primary,
                onTap: () {
                  setState(() {
                    activeTab = 2;
                  });
                },
              ),
              BottomBarItem(
                Icons.settings,
                "Setting",
                isActive: activeTab == 3,
                activeColor: primary,
                onTap: () {
                  setState(() {
                    activeTab = 3;
                  });
                },
              ),
              BottomBarItem(Icons.info,
                "Info",
                isActive: activeTab == 4,
                activeColor: primary,
                onTap: () {
                  setState(() {
                    activeTab = 4;
                  });
                },
              ),
            ]
          )
        ),
    );
  }

  Widget getBarPage(){
    return 
      IndexedStack(
        index: activeTab,
        children: <Widget>[
          HomePage(),
          UserPage(),
          ScanQRCode(),
          SettingPage(),
          AboutPage(),
        ],
      );
  }
}