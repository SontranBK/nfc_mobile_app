import 'package:badges/badges.dart';
import 'package:app/data/json.dart';
import 'package:app/theme/colors.dart';
import 'package:app/widgets/avatar_image.dart';
import 'package:app/widgets/user_box.dart';
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
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 180,
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
            AvatarImage(profile, isSVG: false, width: 42, height: 42),
            SizedBox(width: 17,),
            Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  // color: Colors.red,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hello Son Tran BK,", style: TextStyle(color: Colors.grey, fontSize: 16),),
                      SizedBox(height: 5,),
                      Text(widget.title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
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
}