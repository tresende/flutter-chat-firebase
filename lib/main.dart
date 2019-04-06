import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  Firestore
  .instance
  .collection('mensagens')
  .document()
  .collection('media')
  .document()
  .setData({
    'from': 'Camila',
    'texto': 'imagem aqui',
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
