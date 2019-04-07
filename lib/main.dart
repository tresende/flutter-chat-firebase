import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  DocumentSnapshot snapshot = await Firestore.instance
      .collection('mensagens')
      .document('-LbnF9Djo0G1OVhvU9iZ')
      .get();
  // print(snapshot.documentID);
  // print(snapshot.data);

  // QuerySnapshot list =
  //     await Firestore.instance.collection('mensagens').getDocuments();
  // print(list.documents);
  // for (DocumentSnapshot doc in list.documents) {
  //   print(doc.data);
  // }

  Firestore.instance.collection('mensagens').snapshots().listen((snapshot) {
    for (DocumentSnapshot doc in snapshot.documents) {
      print(doc.data);
    }
  });

  // Firestore
  // .instance
  // .collection('mensagens')
  // .document()
  // .collection('media')
  // .document()
  // .setData({
  //   'from': 'Camila',
  //   'texto': 'imagem aqui',
  // });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
