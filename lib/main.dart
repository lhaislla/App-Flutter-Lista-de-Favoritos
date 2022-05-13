import 'package:app_favorito_dsi/views/widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  runApp(const MyApp());
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyAaFo6b1cvDK2N8kYZntQ4DIk_hsq5Ciis',
          appId: '1:889939815861:android:888bf87a761dc461027dfc',
          messagingSenderId: '889939815861',
          projectId: 'palavras-7a041'));
  FirebaseFirestore.instance;
  var collection = FirebaseFirestore.instance.collection('Parpalavra');
  collection.doc("palavra").set({"Parpalavra": "Test"});
}
