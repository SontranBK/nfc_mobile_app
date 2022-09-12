import 'dart:io';

import 'package:app/repository/repository.dart';
import 'package:app/view/about.dart';
import 'package:app/view/common/form_row.dart';
import 'package:app/view/tag_read.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/view/ScanQR.dart';
import 'package:app/view/GenerateQR.dart';
import 'package:app/view/login.dart';
import 'package:app/view/scan_new.dart';



class App extends StatelessWidget {
  static Future<Widget> withDependency() async {
    final repo = await Repository.createInstance();
    return MultiProvider(
      providers: [
        Provider<Repository>.value(
          value: repo,
        ),
      ],
      child: App(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _Home(),
      theme: _themeData(Brightness.light),
      darkTheme: _themeData(Brightness.dark),
    );
  }
}

class _Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BK Lab Manager'),//Tên ứng dung
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.all(2),
        children: [
          FormSection(children: [
            FormRow(
              title: Text('Login'),
              trailing: Icon(Icons.chevron_right),
              onTap: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) => MyApp(),
              )),
            ),
          ]
          ),
          FormSection(children: [
            FormRow(
              title: Text('Read NFC cards'),
              trailing: Icon(Icons.chevron_right),
              onTap: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) => TagReadPage.withDependency(),
              )),
            ),
            FormRow(
              title: Text('QR Code Scanner'),
              trailing: Icon(Icons.chevron_right),
              onTap: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) => MyHome(),
              )),
            ),
            FormRow(
              title: Text('QR Code Scanner 2'),
              trailing: Icon(Icons.chevron_right),
              onTap: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) => ScanQRCode(),
              )),
            ),
            FormRow(
              title: Text('Generate QR Code'),
              trailing: Icon(Icons.chevron_right),
              onTap: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) => GenerateQRPage(),
              )),
            ),
          ]),
          FormSection(children: [
            FormRow(
              title: Text('Infomation'), //Thong tin them ve ung dung: ten ung dung, phien ban, chinh sach bao mat
              trailing: Icon(Icons.chevron_right),
              onTap: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) => AboutPage(),
              )),
            ),
          ]),
        ],
      ),
    );
  }
}

ThemeData _themeData(Brightness brightness) {
  return ThemeData(
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
