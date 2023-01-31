// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, unused_import, avoid_web_libraries_in_flutter
import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/stranice/pocetna_stranica.dart';
import 'package:flutter/material.dart';
import 'autentikacija/glavna_stranica.dart';
import 'autentikacija/autentifikaciona_stranica.dart';
import 'stranice/login_stranica.dart';
import 'stranice/registracija_stranica.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GlavnaStranica(),
    );
  }
}
