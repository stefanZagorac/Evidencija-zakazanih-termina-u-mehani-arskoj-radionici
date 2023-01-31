// ignore_for_file: unused_import, depend_on_referenced_packages, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class PretragaStranica extends StatelessWidget {
  const PretragaStranica({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pretraga',
      theme: ThemeData(
          primarySwatch: Colors.grey,
          // ignore: deprecated_member_use
          accentColor: Colors.grey),
      debugShowCheckedModeBanner: false,
      home: const PretraziStranica(),
    );
  }
}

class PretraziStranica extends StatefulWidget {
  const PretraziStranica({Key? key}) : super(key: key);

  @override
  State<PretraziStranica> createState() => _PretraziStranicaState();
}

class _PretraziStranicaState extends State<PretraziStranica> {
  List searchResult = [];

  void searchFromFirebase(String query) async {
    final result = await FirebaseFirestore.instance
        .collection('products')
        .where('makeArr', arrayContains: query)
        .get();

    setState(() {
      searchResult = result.docs.map((e) => e.data()).toList();
    });
  }

  List filterResult = [];

  void filter(String value) async {
    final int? number = int.tryParse(value);
    final result = await FirebaseFirestore.instance
        .collection('products')
        .where('price', isGreaterThan: number)
        .get();

    setState(() {
      searchResult = result.docs.map((e) => e.data()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          title: const Text(
            "Pretraga",
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: Container(
        color: Colors.grey[850],
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
              ),
              child: Card(
                color: Colors.grey[300],
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusColor: Colors.orangeAccent,
                    hintText: 'Filtriraj po ceni vecoj od:',
                  ),
                  onChanged: (value) {
                    filter(value);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                color: Colors.grey[300],
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusColor: Colors.orangeAccent,
                    hintText: 'Pretraži',
                  ),
                  onChanged: (query) {
                    searchFromFirebase(query);
                  },
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: searchResult.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.grey[500],
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                      textColor: Colors.grey[850],
                      title: Text(
                        searchResult[index]['name'],
                        style: TextStyle(color: Colors.black),
                      ),
                      subtitle: Text(searchResult[index]['make'] +
                          '\n' +
                          searchResult[index]['date'] +
                          '\n' +
                          'Cena: ' +
                          searchResult[index]['price'].toString() +
                          ' rsd'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
