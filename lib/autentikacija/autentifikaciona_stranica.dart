// ignore_for_file: unused_import, duplicate_import, depend_on_referenced_packages

import 'package:firstapp/stranice/login_stranica.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/stranice/registracija_stranica.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/stranice/pocetna_stranica.dart';
import 'package:flutter/material.dart';

class AutentifikacionaStranica extends StatefulWidget {
  const AutentifikacionaStranica({super.key});

  @override
  State<AutentifikacionaStranica> createState() =>
      _AutentifikacionaStranicaState();
}

class _AutentifikacionaStranicaState extends State<AutentifikacionaStranica> {
  bool prikaziLoginStranicu = true;

  void biracEkrana() {
    setState(() {
      prikaziLoginStranicu = !prikaziLoginStranicu;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (prikaziLoginStranicu) {
      return LoginStranica(
        prikaziStranicuZaRegistraciju: biracEkrana,
      );
    } else {
      return RegistracijaStranica(
        prikaziLoginStranicu: biracEkrana,
      );
    }
  }
}
