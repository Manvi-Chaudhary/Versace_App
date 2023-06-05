import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:app/services/Database.dart';

class WishlistProvider with ChangeNotifier, DiagnosticableTreeMixin {
  int? index = null;

  void ispresent(int i) {
    index = i;
    notifyListeners();
  }

  void remove() {
    index = null;
    notifyListeners();
  }
}
