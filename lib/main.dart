import 'package:app/view/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:app/view/intro_screen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  runApp(await Intro_Screen());
      
}
