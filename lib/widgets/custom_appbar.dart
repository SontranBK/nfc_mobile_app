import 'package:badges/badges.dart';
import 'package:app/data/json.dart';
import 'package:app/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class CustomAppbar extends StatefulWidget with PreferredSizeWidget{
  CustomAppbar({Key? key, required this.title}) : super(key: key);
  String title;

  @override
  _CustomAppbarState createState() => _CustomAppbarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight+43);
}

class _CustomAppbarState extends State<CustomAppbar> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    double  heightR,widthR;
    heightR = MediaQuery.of(context).size.height / 1080; //v26
    widthR = MediaQuery.of(context).size.width / 2400;
    var curR = widthR;
    final User? user =
        auth.currentUser;
    var string = user?.email ?? 0 ;
    var result;
    var  i = 0;
    while(string.toString().codeUnitAt(i) != 46){
      i++;
      print(i);
    }
    result = string.toString().substring(0, i);
    return Container(
      height: 180*heightR,
      padding: EdgeInsets.only(left: 130*widthR, right: 130*widthR, top: 50*heightR),
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
          CircleAvatar(
            backgroundImage: NetworkImage(
                "https://res.cloudinary.com/teepublic/image/private/s--WlHDkW0o--/t_Preview/b_rgb:0195c3,c_lpad,f_jpg,h_630,q_90,w_1200/v1570281377/production/designs/6215195_0.jpg"),
            radius: 180*curR,
          ),
          SizedBox(width: 100*curR,),
          Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                // color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hello ${result.toUpperCase()}",
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 100*curR
                      ),
                    ),
                    SizedBox(height: 5*heightR,),
                    Text(widget.title,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 120*curR
                      ),),
                  ],
                ),
              )
          ),
          SizedBox(width: 15*curR,),
          Container(
            padding: EdgeInsets.all( 30*widthR),
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
            child: Badge(
                padding: EdgeInsets.all(15*curR),
                position: BadgePosition.topEnd(top: -5, end: 2),
                badgeContent: Text('', style: TextStyle(color: Colors.white),),
                child: Icon(Icons.notifications_rounded)
            ),
          ),
        ],
      ),
    );

  }
}