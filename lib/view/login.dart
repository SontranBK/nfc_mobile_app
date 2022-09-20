import 'package:app/view/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:app/view/home.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  @override
  Widget build(BuildContext context) {
    Widget example1 = SplashScreenView(
      navigateRoute: SignPage(),
      duration: 5000,
      imageSize: 300,
      imageSrc: "assets/splashscreen_image.png",
      text: "BK Lab Manager",
      textType: TextType.ColorizeAnimationText,
      textStyle: TextStyle(
        fontSize: 40.0,
      ),
      colors: [
        Colors.purple,
        Colors.blue,
        Colors.yellow,
        Colors.red,
      ],
      backgroundColor: Colors.white,
    );

    return MaterialApp(
      home: example1,
      theme: _themeData(Brightness.light),
      darkTheme: _themeData(Brightness.light),
    );
  }
}

class SignPage extends StatefulWidget {
  const SignPage({Key? key}) : super(key: key);

  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => Home(),
                        ));
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
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => SignUpPage(),
                        ));
                      },
                    )
                  ],
                ),
              ],
            ))
    );
  }
}
ThemeData _themeData(Brightness brightness) {
  return ThemeData(
    fontFamily: "Poppins",
    brightness: brightness,
    // Matches app icon color.
    primarySwatch:  MaterialColor(0xFF4D8CFE, <int, Color>{
      50: Color(0xFFEAF1FF),
      100: Color(0xFFCADDFF),
      200: Color(0xFFA6C6FF),
      300: Color(0xFF82AFFE),
      400: Color(0xFF689DFE),
      500: Color(0xFF4D8CFE),
      600: Color(0xFF4684FE),
      700: Color(0xFF3D79FE),
      800: Color(0xFF346FFE),
      900: Color(0xFF255CFD),
    }),
    appBarTheme: AppBarTheme(
      brightness: Brightness.dark,
    ),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      errorStyle: TextStyle(height: 0.75),
      helperStyle: TextStyle(height: 0.75),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
      minimumSize: Size.fromHeight(40),
    )),
    scaffoldBackgroundColor: brightness == Brightness.dark
        ? Colors.black
        : null,
    cardColor: brightness == Brightness.dark
        ? Color.fromARGB(255, 28, 28, 30)
        : null,
    dialogTheme: DialogTheme(
      backgroundColor: brightness == Brightness.dark
          ? Color.fromARGB(255, 28, 28, 30)
          : null,
    ),
    highlightColor: brightness == Brightness.dark
        ? Color.fromARGB(255, 44, 44, 46)
        : null,
    splashFactory: NoSplash.splashFactory,
  );
}

