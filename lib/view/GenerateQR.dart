import 'package:app/view/User_Profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class GenerateQRPage extends StatefulWidget {
  @override
  _GenerateQRPageState createState() => _GenerateQRPageState();
}
class _GenerateQRPageState extends State<GenerateQRPage> {


  final FirebaseAuth auth = FirebaseAuth.instance;

  CollectionReference profile =
  FirebaseFirestore.instance.collection("User_Profile");

  final Stream<QuerySnapshot> user_profile =
  FirebaseFirestore.instance.collection('User_Profile').snapshots();

  @override
  Widget build(BuildContext context) {
    final User? user =
        auth.currentUser; // push user info to firebase when they update status
    final uid = user?.uid;
    String retrieved_user_id = "";

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
              StreamBuilder<QuerySnapshot>(
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
                      retrieved_user_id = data['ID'];
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
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(80, 60, 80, 40),
                child: Text('Scan QR code above for infomation exchange\nOr create one if you do not have yet',style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
              ),
              Container(
                height: 50,
                margin: EdgeInsets.only(top: 60),
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {});
                      if(retrieved_user_id == uid) {
                          AwesomeDialog(
                            context: context,
                            keyboardAware: true,
                            dismissOnBackKeyPress: false,
                            dialogType: DialogType.warning,
                            animType: AnimType.bottomSlide,
                            btnCancelText: "No, cancel",
                            btnOkText: "Yes, continue",
                            title: 'Continue?',
                            // padding: const EdgeInsets.all(5.0),
                            desc:
                            'You already had a personal QR code, changing your QR will make your present QR be deleted.\nOnce proceed, you must create a new profile for your QR code.\nPlease confirm that you want to proceed.',
                            btnCancelOnPress: () {},
                            btnOkOnPress: () {FirebaseFirestore.instance
                                .collection("User_Profile")
                                .doc(uid!)
                                .delete();
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) => UserProfile()));},
                          ).show();
                        }
                      else {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) => UserProfile()));
                      }
                    },
                    child: const Text(
                      'Create or change personal QR',
                      style: TextStyle(fontSize: 18),
                    ),

                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}