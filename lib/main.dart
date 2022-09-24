import 'package:app/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:app/view/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:app/view/auth_bloc.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await Firebase.initializeApp();
  runApp(MyApp(
      new AuthBloc(),
      MaterialApp(
        home: LogInPage(),
      )
  ));

}
class MyApp extends InheritedWidget {
  final AuthBloc authBloc;
  final Widget child;
  MyApp(this.authBloc, this.child) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

  static MyApp? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyApp>();
  }
}






