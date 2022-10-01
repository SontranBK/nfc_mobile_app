import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class EmptyPage extends StatefulWidget {
  @override
  _EmptyPageState createState() => _EmptyPageState();
}
class _EmptyPageState extends State<EmptyPage> {

  final Stream<QuerySnapshot> user = FirebaseFirestore.instance.collection(
      'users').snapshots();

  // final FirebaseAuth auth = FirebaseAuth.instance;
  // final ref = FirebaseDatabase.instance.ref();
  // String users="";
  // String id = "";

  // Future<void> readJson() async {
  //   final snapshot = await ref.child('users/$users.users.uid/name').get();
  //   if (snapshot.exists) {
  //     print('Value :${snapshot.value}');
  //   } else {
  //     print('No data available.');
  //   }
  //   final User? user = auth.currentUser;
  //   final uid = user?.uid;
  //   final String response = await rootBundle.loadString('nfcmobileapp-main-default-rtdb-export.json');
  //   final data = await json.decode(response);
  //   // print('data: ${data}');
  //   print('UID: ${uid}');
  //   setState(() {
  //     users = data["users"][uid]["name"];
  //   });
  // }

  // void inputData() {
  //   final User? user = auth.currentUser;
  //   final uid = user?.uid;
  //   // here you write the codes to input the data into firestore
  // }
  @override
  Widget build(BuildContext context) {
    // final User? user = auth.currentUser;
    // final uid = user?.uid;
    // readJson();
    // print('Họ tên: ${users}');
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
            Icon(
              Icons.developer_mode,
              size: 200,
            ),
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
                  'Email: ${data.docs[index]['Email']}',
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
