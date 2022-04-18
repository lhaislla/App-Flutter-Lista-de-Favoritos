import 'package:app_favorito_dsi/widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  runApp(const MyApp());
  await Firebase.initializeApp();
  FirebaseFirestore.instance
      .collection("Parpalavra")
      .doc("palavra")
      .set({"Parpalavra": "Test"});
}
