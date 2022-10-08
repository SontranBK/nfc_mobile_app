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
          CircleAvatar(
            backgroundImage: NetworkImage(
                "https://scontent.fhan2-5.fna.fbcdn.net/v/t39.30808-6/256625965_2055617961261792_7247980732642938730_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=xH0qJA0PkR4AX-Mnt_x&_nc_ht=scontent.fhan2-5.fna&oh=00_AT-b5ApATd0KAGRJvfL0PAweRoIOj3RznRvOtrHAuFlSNg&oe=63459624"),
            radius: 27,
          ),
          SizedBox(width: 17,),
          Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                // color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hello ${result.toUpperCase()}", style: TextStyle(color: Colors.grey[700], fontSize: 16),),
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