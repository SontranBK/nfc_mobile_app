import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserStatusPage extends StatefulWidget {
  @override
  _UserStatusPageState createState() => _UserStatusPageState();
}
class _UserStatusPageState extends State<UserStatusPage> {

  final Stream<QuerySnapshot> user = FirebaseFirestore.instance.collection(
      'users').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Of Online Users'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.recent_actors,
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
            SizedBox(
              height: 500,

              child: _buildSuggestions(),
            ),
          ], //<Widget>[]
        ), //Column
      ), //Center
    );
  }
  Widget _buildSuggestions() {

    return StreamBuilder<QuerySnapshot>(
      stream: user,
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot,) {
        if (snapshot.hasError) {
          return Text('Something went wrong.');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading');
        }

        final data = snapshot.requireData;
        return ListView.builder(
          padding: const EdgeInsets.all(20.0),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: data.size,
          itemBuilder: (context, index) {

            return Container(
              alignment: Alignment.center,
              child: Text(
                  '\n$index: ${data.docs[index]['Email']} CHECKED IN AT ${data.docs[index]['Time']}',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  )),
            );
          },
        );
      },
    );
  }


}
