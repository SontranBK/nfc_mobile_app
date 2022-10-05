import 'package:app/view/User_Profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQRPage extends StatefulWidget {
  @override
  _GenerateQRPageState createState() => _GenerateQRPageState();
}
class _GenerateQRPageState extends State<GenerateQRPage> {

  final Stream<QuerySnapshot> user_profile = FirebaseFirestore.instance.collection('User_Profile').snapshots();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your personal QR code'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.qr_code_2,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 50,
              ),
              _bodyQR(),
              SizedBox(
                height: 10,
              ),
              Text("Scan QR code above\nfor infomation exchange\n\nOr create one if\nyou do not have yet", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => UserProfile()));
                    // content();
                  },
                  child: Text('Create or change personal QR')

              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _bodyQR(){
    final User? user = auth.currentUser; // push user info to firebase when they update status
    final uid = user?.uid;
    return StreamBuilder<QuerySnapshot>(
        stream: user_profile,
        builder: (
            BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot,
            ){
          if (snapshot.hasError) {
            return Text('Something went wrong.');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading');
          }
          return Column(
            children: snapshot.data!.docs
                .map((DocumentSnapshot document){
              Map<String, dynamic> data =
              document.data()! as Map<String, dynamic>;
              if(data['ID'] == uid){
                return Column(
                  children: [
                    QrImage(
                      // data: "BKLAB | " + data['Phone Number'].toString() + " | " + data['MS Teams'].toString() + " | " + data['Facebook URL'].toString() + " | " + data['Instagram URL'].toString(),
                      size: 300,
                      embeddedImage: AssetImage('images/logo.png'),
                      embeddedImageStyle: QrEmbeddedImageStyle(
                          size: Size(80,80)
                      ),
                      data: "BKLAB | " + data['Phone Number'].toString() + " | " + data['MS Teams'].toString() + " | " + data['Facebook URL'].toString() + " | " + data['Instagram URL'].toString(),
                    ),
                  ],
                );
              }

              else{
                return Text("");
              }

            }
            )
                .toList()
                .cast(),
          );
        }
    );
  }
}