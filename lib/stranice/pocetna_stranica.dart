// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors, unused_import, depend_on_referenced_packages, use_build_context_synchronously, unused_element, sort_child_properties_last, avoid_web_libraries_in_flutter

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pretraga_stranica.dart';

class PocetnaStranica extends StatefulWidget {
  const PocetnaStranica({super.key});

  @override
  State<PocetnaStranica> createState() => _PocetnaStranicaState();
}

class _PocetnaStranicaState extends State<PocetnaStranica> {
  final korisnik = FirebaseAuth.instance.currentUser!;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _makeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final CollectionReference _products =
      FirebaseFirestore.instance.collection('products');

  final Query _productss =
      FirebaseFirestore.instance.collection("products").orderBy('price');

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    _nameController.text = '';
    _priceController.text = '';
    _makeController.text = '';
    _dateController.text = '';
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Container(
            color: Colors.grey[500],
            child: Padding(
              padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Naziv',
                    ),
                  ),
                  TextField(
                    controller: _makeController,
                    decoration: const InputDecoration(
                      labelText: 'Marka i model automobila',
                    ),
                  ),
                  TextField(
                    controller: _dateController,
                    decoration: const InputDecoration(
                      labelText: "Vreme i datum u formatu 'DD.MM.GGGG-24h'",
                    ),
                  ),
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    controller: _priceController,
                    decoration: const InputDecoration(
                      labelText: 'Cena',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent),
                    child: const Text(
                      'Dodaj',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () async {
                      final String name = _nameController.text;
                      final int? price = int.tryParse(_priceController.text);
                      final String make = _makeController.text;
                      List searchList = [];
                      for (var i = 1; i <= make.length; i++) {
                        var nextEl = make.substring(0, i).toLowerCase();
                        searchList.add(nextEl);
                        nextEl = make.substring(0, i);
                        searchList.add(nextEl);
                      }

                      final String date = _dateController.text;
                      if (price != null) {
                        await _products.add({
                          "name": name,
                          "price": price,
                          "make": make,
                          "date": date,
                          'makeArr': searchList,
                        });

                        _nameController.text = '';
                        _priceController.text = '';
                        _makeController.text = '';
                        _dateController.text = '';

                        Navigator.of(context).pop();
                      }
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot['name'];
      _priceController.text = documentSnapshot['price'].toString();
      _makeController.text = documentSnapshot['make'];
      _dateController.text = documentSnapshot['date'];
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Container(
            color: Colors.grey[500],
            child: Padding(
              padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Naziv'),
                  ),
                  TextField(
                    controller: _makeController,
                    decoration: const InputDecoration(
                        labelText: 'Marka i model automobila'),
                  ),
                  TextField(
                    controller: _dateController,
                    decoration: const InputDecoration(
                        labelText: "Vreme i datum u formatu 'DD.MM.GGGG-24h'"),
                  ),
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    controller: _priceController,
                    decoration: const InputDecoration(
                      labelText: 'Cena',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent),
                    child: const Text(
                      'Ažuriraj',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () async {
                      final String name = _nameController.text;
                      final int? price = int.tryParse(_priceController.text);
                      final String make = _makeController.text;
                      final String date = _dateController.text;
                      List searchList = [];
                      for (var i = 1; i <= make.length; i++) {
                        var nextEl = make.substring(0, i).toLowerCase();
                        searchList.add(nextEl);
                        nextEl = make.substring(0, i);
                        searchList.add(nextEl);
                      }

                      if (price != null) {
                        await _products.doc(documentSnapshot!.id).update({
                          "name": name,
                          "price": price,
                          "make": make,
                          "date": date,
                          "makeArr": searchList,
                        });
                        _nameController.text = '';
                        _priceController.text = '';
                        _makeController.text = '';
                        _dateController.text = '';
                        Navigator.of(context).pop();
                      }
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> _delete(String productId) async {
    await _products.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Uspešno ste obrisali ovaj termin')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.orangeAccent,
          foregroundColor: Colors.grey[850],
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PretraziStranica()),
                );
              },
            )
          ],
          title: Text('Termini'),
          leading: GestureDetector(
            onTap: (() {
              FirebaseAuth.instance.signOut();
            }),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Odjava',
                  style: TextStyle(
                    color: Colors.grey[850],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Container(
          color: Colors.grey[850],
          child: StreamBuilder(
            stream: _productss.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return ListView.builder(
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data!.docs[index];
                    return Card(
                      color: Colors.grey[500],
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(documentSnapshot['name']),
                        subtitle: Text(documentSnapshot['make'] +
                            '\n' +
                            documentSnapshot['date'] +
                            '\n' +
                            'Cena: ' +
                            documentSnapshot['price'].toString() +
                            ' rsd'),
                        trailing: SizedBox(
                          width: 96,
                          child: Row(
                            children: [
                              IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () => _update(documentSnapshot)),
                              IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () =>
                                      _delete(documentSnapshot.id)),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _create(),
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
          backgroundColor: Colors.orangeAccent,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat);
  }
}
