// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, annotate_overrides, unused_import, depend_on_referenced_packages

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/stranice/pocetna_stranica.dart';
import 'package:flutter/material.dart';

class LoginStranica extends StatefulWidget {
  final VoidCallback prikaziStranicuZaRegistraciju;
  const LoginStranica({Key? key, required this.prikaziStranicuZaRegistraciju})
      : super(key: key);

  @override
  State<LoginStranica> createState() => _LoginStranicaState();
}

class _LoginStranicaState extends State<LoginStranica> {
  final _emailKontroler = TextEditingController();
  final _lozinkaKontroler = TextEditingController();
  Future prijava() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailKontroler.text.trim(),
      password: _lozinkaKontroler.text.trim(),
    );
  }

  @override
  void dispose() {
    _emailKontroler.dispose();
    _lozinkaKontroler.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(
                Icons.construction_rounded,
                color: Colors.orangeAccent,
                size: 100,
              ),
              SizedBox(height: 30),
              Text(
                'Dobrodošli!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Imajte uvid u sve zakazane popravke',
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
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: prijava,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                        child: Text(
                      'Prijavite se',
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
                    'Niste registrovani?',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.prikaziStranicuZaRegistraciju,
                    child: Text(
                      ' Registrujte se',
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
