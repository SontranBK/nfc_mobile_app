import 'package:app/view/app.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
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

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(13),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 70),
                child: const Text(
                  'Welcome Back!',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
              height: 300,
              padding: const EdgeInsets.all(35),
              margin: EdgeInsets.only(bottom: 30),
              alignment: Alignment.center,
              child: Image.asset('assets/lab_logo.png'),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    // borderSide:
                    // BorderSide(width: 3, color: Colors.greenAccent), //<-- SEE HERE
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  labelText: 'User Name',
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
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
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  //forgot password screen
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontSize: 17
                  ),
                ),
              ),
            ),
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
                margin: EdgeInsets.only(top: 60),
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text(
                    'Login',
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
                const Text('Do not have an account?',
                  style: TextStyle(
                    fontSize: 18,
                  ),),
                TextButton(
                  child: const Text(
                    'Sign up',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    //signup screen
                  },
                )
              ],
            ),
            Center(
                //height: 50,
                //padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => App(),
                  ));
                },
                child: const Text('Go back!'),
              ),),
          ],
        ));
  }
}
