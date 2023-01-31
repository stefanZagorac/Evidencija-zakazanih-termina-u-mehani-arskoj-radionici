// ignore_for_file: prefer_const_constructors, unused_import, depend_on_referenced_packages

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/stranice/pocetna_stranica.dart';
import 'package:flutter/material.dart';

class RegistracijaStranica extends StatefulWidget {
  final VoidCallback prikaziLoginStranicu;
  const RegistracijaStranica({
    Key? key,
    required this.prikaziLoginStranicu,
  }) : super(key: key);

  @override
  State<RegistracijaStranica> createState() => _RegistracijaStranicaState();
}

class _RegistracijaStranicaState extends State<RegistracijaStranica> {
  final _emailKontroler = TextEditingController();
  final _lozinkaKontroler = TextEditingController();
  final _lozinkaKontroler2 = TextEditingController();
  @override
  void dispose() {
    _emailKontroler.dispose();
    _lozinkaKontroler.dispose();
    _lozinkaKontroler2.dispose();
    super.dispose();
  }

  Future registrujSe() async {
    if (potvrdjivacLozinke()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailKontroler.text.trim(),
          password: _lozinkaKontroler.text.trim());
    }
  }

  bool potvrdjivacLozinke() {
    if (_lozinkaKontroler.text.trim() == _lozinkaKontroler2.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(
                Icons.app_registration_sharp,
                color: Colors.orangeAccent,
                size: 100,
              ),
              SizedBox(height: 30),
              Text(
                'Registracija',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Molimo vas unesite tačne podatke.',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: TextField(
                      controller: _emailKontroler,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Unesite vaš e-mail'),
                      cursorColor: Colors.white,
                      cursorHeight: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: TextField(
                      controller: _lozinkaKontroler,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Unesite lozinku'),
                      cursorColor: Colors.white,
                      cursorHeight: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: TextField(
                      controller: _lozinkaKontroler2,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Potvrdite lozinku'),
                      cursorColor: Colors.white,
                      cursorHeight: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: registrujSe,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                        child: Text(
                      'Registrujte se',
                      style: TextStyle(
                          color: Colors.grey[850],
                          fontSize: 22,
                          fontWeight: FontWeight.w700),
                    )),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Već ste se registrovali?',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.prikaziLoginStranicu,
                    child: Text(
                      ' Prijavite se',
                      style: TextStyle(
                        color: Colors.orangeAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
