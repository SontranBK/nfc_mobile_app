import 'package:app/theme/colors.dart';
import 'package:app/widgets/action_box.dart';
import 'package:app/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:app/view/empty_page.dart';

class UserPage extends StatefulWidget {
  const UserPage({ Key? key }) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
     return 
      Scaffold(
        backgroundColor: secondary,
        appBar: CustomAppbar(title: "User Management!"),
        body: getBody(),
      );
  }

  getBody(){
    double  heightR,widthR;
    heightR = MediaQuery.of(context).size.height / 1080; //v26
    widthR = MediaQuery.of(context).size.width / 2400;
    var curR = widthR;
    return
    SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 50*heightR,),
          getActions(),
          SizedBox(height: 50*heightR,),

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
              child: ActionBox(title: "Call An Instant Meeting", icon: Icons.groups, bgColor: light_pink, linkscreen: EmptyPage())
          ),
          SizedBox(width: 30,),
        ],
      );
  }

}