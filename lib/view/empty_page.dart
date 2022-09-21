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
        title: Text('An Empty Page'),
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
      body: const Center(
        child: Text('  This is an empty page.\n  This page is created for future features reservation.'
            '\n  There will be a feature here in the near future.\n  We appreciate your patience'),
      ),
    );
  }
}