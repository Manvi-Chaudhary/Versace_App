import "package:app/services/Database.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    final String? user = Provider.of<String?>(context);
    return StreamBuilder<QuerySnapshot>(
        stream: Dataservice(uid: user!).cartItems,
        builder: (context, snapshot) {
          return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                title: Text(
                  "SHOPPING BAG",
                ),
                titleTextStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                centerTitle: true,
              ),
              body: (snapshot.hasData)
                  ? Column(
                      children: [
                        SizedBox(
                          height: 500,
                          child: ListView.separated(
                              itemBuilder: (context, index) => Container(
                                  color: Colors.grey,
                                  height: 100,
                                  margin: EdgeInsets.all(5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        child: Center(
                                            child: Image.asset(
                                                "assets/images/" +
                                                    snapshot.data!.docs[index]
                                                        .get("Image"))),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 2, color: Colors.black)),
                                      ),
                                      Column(
                                        children: [
                                          Text(snapshot.data!.docs[index]
                                              .get("Name")),
                                          SizedBox(height: 5),
                                          Text(
                                              "${snapshot.data!.docs[index].get("Price")}"),
                                          SizedBox(height: 5),
                                          Text(
                                            snapshot.data!.docs[index]
                                                .get("ProductID"),
                                            style: TextStyle(fontSize: 10),
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                Dataservice(uid: user)
                                                    .removecart(snapshot
                                                        .data!.docs[index].id);
                                              },
                                              child: Text("Remove"))
                                        ],
                                      )
                                    ],
                                  )),
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 10),
                              itemCount: snapshot.data!.docs.length),
                        ),
                      ],
                    )
                  : Container());
        });
  }
}
