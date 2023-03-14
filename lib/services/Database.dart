import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Dataservice {
  String uid = "";
  Dataservice({required this.uid});

  CollectionReference record = FirebaseFirestore.instance.collection("data");

  Future cred(String email, String username, String password) async {
    return await record
        .doc(uid)
        .set({"Email": email, "Username": username, "Password": password});
  }

  Future wishlist(
      String productID, String image, String name, int price) async {
    return await record.doc(uid).collection("Wishlist").doc().set({
      "ProductID": productID,
      "Image": image,
      "Name": name,
      "Price": price,
    });
  }

  Future cart(
      String productID, String image, String name, int price, int size) async {
    return await record.doc(uid).collection("Cart").doc().set({
      "ProductID": productID,
      "Image": image,
      "Name": name,
      "Price": price,
      "Size": size,
    });
  }

  Future removewish(id) async {
    return await record.doc(uid).collection("Wishlist").doc(id).delete();
  }

  Future removecart(id) async {
    return await record.doc(uid).collection("Cart").doc(id).delete();
  }

  Future<String?> isAlreadyPresent(String productID) async {
    QuerySnapshot s = await record
        .doc(uid)
        .collection("Wishlist")
        .where("ProductID", isEqualTo: productID)
        .get();
    print(s.docs.first);
    if (s.docs.isEmpty) {
      return null;
    }
    return "YES";
  }

  Stream<QuerySnapshot> get wish {
    return record.doc(uid).collection("Wishlist").snapshots();
  }

  Stream<QuerySnapshot> get cartItems {
    return record.doc(uid).collection("Cart").snapshots();
  }

  Future<String?> checkcart(String productID) async {
    QuerySnapshot s = await record
        .doc(uid)
        .collection("Cart")
        .where("ProductID", isEqualTo: productID)
        .get();
    if (s.docs == []) {
      return null;
    }
    return "ADDED TO CART";
  }

  Future<String?> checkwish(String productID) async {
    QuerySnapshot s = await record
        .doc(uid)
        .collection("Wishlist")
        .where("ProductID", isEqualTo: productID)
        .get();
    if (s.docs == []) {
      return null;
    }
    return s.docs[0].id;
  }

  Future<String?> getemail(String username, String password) async {
    QuerySnapshot s = await record
        .where("Username", isEqualTo: username)
        .where("Password", isEqualTo: password)
        .get();
    if (s.docs == []) {
      return null;
    }
    return s.docs[0]["Email"];
  }
}
