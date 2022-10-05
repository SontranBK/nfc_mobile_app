import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class UserStatusPage extends StatefulWidget {
  @override
  _UserStatusPageState createState() => _UserStatusPageState();
}

class _UserStatusPageState extends State<UserStatusPage> {
  DateTime now = DateTime.now();
  final Stream<QuerySnapshot> user =
  FirebaseFirestore.instance.collection('users').snapshots();

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
            Container(
              child: Icon(
                Icons.import_contacts,
                size: 100,
              ),
            ),
            SizedBox(
              height: 600,
              child: _buildSuggestions(),
            ),
          ], //<Widget>[]
        ), //Column
      ), //Center
    );
  }

  Widget _buildSuggestions() {
    String today = DateFormat('dd MMM yyyy').format(now);
    return StreamBuilder<QuerySnapshot>(
      stream: user,
      builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot,
          ) {
        if (snapshot.hasError) {
          return Text('Something went wrong.');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading');
        }

        // final data = snapshot.requireData;
        bool day = false;
        return ListView(
          children: snapshot.data!.docs
              .map((DocumentSnapshot document) {
            Map<String, dynamic> data =
            document.data()! as Map<String, dynamic>;
            if (data['Day'].toString() == today) {
              day = false;
            } else if (data['Day'].toString() != today) {
              day = true;
            }
            if (!day) {
              return SizedBox(
                  child: Column(
                    children: [
                      Container(
                        height: 55,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(bottom: 5,top: 10),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          gradient: new LinearGradient(
                            colors: [Colors.white, Colors.cyan],
                            begin: Alignment.centerLeft,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                                data['Email'].toString(),
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                )),
                            Text(
                                'checked in at: '+data['Time'].toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                )),

                          ],
                        ),



                      )
                    ],
                  )
              );
            } else {
              return SizedBox();
            }
          })
              .toList()
              .cast(),
        );
      },
    );
  }
}
