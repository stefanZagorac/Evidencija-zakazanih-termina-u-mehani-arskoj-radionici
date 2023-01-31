// ignore_for_file: unused_import, duplicate_import, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/stranice/login_stranica.dart';
import 'package:firstapp/stranice/pocetna_stranica.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../stranice/login_stranica.dart';
import 'autentifikaciona_stranica.dart';

class GlavnaStranica extends StatefulWidget {
  const GlavnaStranica({super.key});

  @override
  State<GlavnaStranica> createState() => _GlavnaStranicaState();
}

class _GlavnaStranicaState extends State<GlavnaStranica> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PocetnaStranica();
          } else {
            return AutentifikacionaStranica();
          }
        },
      ),
    );
  }
}
