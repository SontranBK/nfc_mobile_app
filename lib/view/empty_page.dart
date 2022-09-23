import 'package:flutter/material.dart';

class EmptyPage extends StatefulWidget {
  @override
  _EmptyPageState createState() => _EmptyPageState();
}
class _EmptyPageState extends State<EmptyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Features Coming Soon!'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.install_mobile,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 100,),
            Icon(
              Icons.developer_mode,
              size: 200,
            ),
            SizedBox(height: 100,),
            Center(
              child: Text('COMING SOON !!!\nThis feature is still in developing process.'
                  '\nThere will be a feature here in the near future.\nWe appreciate and thank you for your patience!',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff006ED3),
                ),
              ),
            ),
          ], //<Widget>[]
        ), //Column
      ), //Center
    );
  }
}

