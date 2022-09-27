import 'dart:async';
import 'package:app/view/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:app/view/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'load_msg_dilog.dart';
import '../main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();

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
  bool showPass = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var _userNameError = "Tài khoản không hợp lệ";
  var _passwordError = "Mật khẩu phải trên 6 kí tự ";
  var _userInvalid = false;
  var _passIvalid = false;

  Widget _entryField(
      bool obscure,
      String title,
      TextEditingController controller,
      var users,
      var error,
      ) {
    return TextField(
      obscureText: obscure,
      controller: controller,
      decoration: InputDecoration(
        errorText: users ? error : null,
        enabledBorder: OutlineInputBorder(
          // borderSide:
          // BorderSide(width: 3, color: Colors.greenAccent), //<-- SEE HERE
          borderRadius: BorderRadius.circular(20.0),
        ),
        labelText: title,
      ),
    );
  }

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
                  child: _entryField(false,'User Name', nameController,_userInvalid,_userNameError)
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Stack(
                    alignment: AlignmentDirectional.centerEnd,
                    children: <Widget>[
                      _entryField(!showPass,'Password', passwordController,_passIvalid,_passwordError),
                      // GestureDetector(
                      //   onTap: onShowPass,
                      //   child: Text(
                      //     showPass ? "Hide" : "Show",
                      //     style: TextStyle(
                      //       color: Colors.blue,
                      //       fontSize: 14,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      // )
                    ],
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
                        _onLoginClick();
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
  
  void _onLoginClick() {
    String email = nameController.text;
    String pass = passwordController.text;
    var authBloc = MyApp.of(context)?.authBloc;
    // LoadingDialog.showLoadingDialog(context, "Loading...");
    authBloc?.signIn(email, pass, () {
      // LoadingDialog.hideLoadingDialog(context);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Home()));
    }, (msg) {
      // LoadingDialog.hideLoadingDialog(context);
      MsgDialog.showMsgDialog(context, "Sign-In", msg);
    });
    setState((){
      if(nameController.text.length < 6 || !nameController.text.contains('@')){
        _userInvalid = true;
      }else{
        _userInvalid = false;
      }
      if(passwordController.text.length < 5){
        _passIvalid = true;
      }else{
        _passIvalid = false;
      }

      // if(!_passIvalid && !_userInvalid){
      //   Navigator.push(context, MaterialPageRoute(
      //     builder: (context) => Home(),
      //   ));
      // }
    });
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

