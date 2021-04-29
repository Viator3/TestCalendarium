import 'package:flutter/material.dart';

class TodosCollection extends ChangeNotifier {
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void addItem(String title) {
    // _firestore.collection('gym').add({
    //   'todo': title,
    //   'isSelected': false,
    // });
  }

  void updateItem(String id, bool isSelected, String title) {
    // _firestore.collection('gym').doc(id).update({
    //   'isSelected': isSelected,
    // });
  }

  // getCollectionAsSteam() => _firestore.collection('gym').snapshots();
}
