import 'package:app/view/login.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app/view/home.dart';


class ChagePasswordPage extends StatefulWidget {
  const ChagePasswordPage({Key? key}) : super(key: key);

  @override
  _ChagePasswordPageState createState() => _ChagePasswordPageState();
}

class _ChagePasswordPageState extends State<ChagePasswordPage> {
  TextEditingController oldpasswordController = TextEditingController();
  TextEditingController newpasswordController = TextEditingController();
  TextEditingController confirmedpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double  heightR,widthR;
    heightR = MediaQuery.of(context).size.height / 1080; //v26
    widthR = MediaQuery.of(context).size.width / 2400;
    var curR = widthR;
    return Scaffold(
        appBar: AppBar(
        title: Text('Update your password'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.sync_lock,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
        backgroundColor: Colors.white,
        body: Padding(
            padding:  EdgeInsets.all(14*heightR),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding:  EdgeInsets.all(11*heightR),
                    margin: EdgeInsets.only(top: 110*heightR),
                    child:  Text(
                      'Change your password',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 158*curR),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding:  EdgeInsets.all(10*heightR),
                    margin: EdgeInsets.only(bottom: 90*heightR,top: 5*heightR),
                    child:  Text(
                      'Confirm your old password and fill in new one!',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 108*curR),
                    )),
                Container(
                  padding:  EdgeInsets.fromLTRB(50*curR,25*heightR, 50*curR, 0),
                  child: TextField(
                    controller: oldpasswordController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        // borderSide:
                        // BorderSide(width: 3, color: Colors.greenAccent), //<-- SEE HERE
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'Old password',
                    ),
                  ),
                ),
                Container(
                  padding:  EdgeInsets.fromLTRB(50*curR,25*heightR, 50*curR, 0),
                  child: TextField(
                    controller: newpasswordController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        // borderSide:
                        // BorderSide(width: 3, color: Colors.greenAccent), //<-- SEE HERE
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'New password',
                    ),
                  ),
                ),
                Container(
                  padding:  EdgeInsets.fromLTRB(50*curR,25*heightR, 50*curR, 0),
                  child: TextField(
                    obscureText: true,
                    controller: confirmedpasswordController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        // borderSide:
                        // BorderSide(width: 3, color: Colors.greenAccent), //<-- SEE HERE
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'Confirm your new password',
                    ),
                  ),
                ),
                Container(
                    height: 80*heightR,
                    margin: EdgeInsets.only(top: 85*heightR),
                    padding:  EdgeInsets.fromLTRB(50*curR,0 , 50*curR, 0),
                    child: ElevatedButton(
                      child:  Text(
                        'Update password',
                        style: TextStyle(fontSize: 144*curR),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => Home(),
                        ));
                      },
                    )),
              ],
            )),
    );

  }
}
