import 'package:app/view/app.dart';
import 'package:app/view/login.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController confirn_passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.all(13),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    margin: EdgeInsets.only(top: 120),
                    child: const Text(
                      'Create new account',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 32),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    margin: EdgeInsets.only(bottom: 90,top: 5),
                    child: const Text(
                      'Lets help you in completing your tasks!',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    )),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: TextField(
                    controller: fullnameController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        // borderSide:
                        // BorderSide(width: 3, color: Colors.greenAccent), //<-- SEE HERE
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'Full Name',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        // borderSide:
                        // BorderSide(width: 3, color: Colors.greenAccent), //<-- SEE HERE
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'User Name',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        // borderSide:
                        // BorderSide(width: 3, color: Colors.greenAccent), //<-- SEE HERE
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: confirn_passwordController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        // borderSide:
                        // BorderSide(width: 3, color: Colors.greenAccent), //<-- SEE HERE
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'Confirm Password',
                    ),
                  ),
                ),
                // Container(
                //   alignment: Alignment.centerRight,
                //   child: TextButton(
                //     onPressed: () {
                //       //forgot password screen
                //     },
                //     child: const Text(
                //       'Forgot Password?',
                //       style: TextStyle(
                //           fontSize: 17
                //       ),
                //     ),
                //   ),
                // ),
                // TextButton(
                //   onPressed: () {
                //     //forgot password screen
                //   },
                //   child: const Text(
                //     'Forgot Password?',
                //   ),
                // ),
                Container(
                    height: 60,
                    margin: EdgeInsets.only(top: 70),
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text(
                        'Register',
                        style: TextStyle(fontSize: 24),
                      ),
                      onPressed: () {
                        print(nameController.text);
                        print(passwordController.text);
                      },
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Already have an account?',
                      style: TextStyle(
                        fontSize: 18,
                      ),),
                    TextButton(
                      child: const Text(
                        'Sign in',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => SignPage(),
                        ));
                      },
                    )
                  ],
                ),
              ],
            )),
    );

  }
}
