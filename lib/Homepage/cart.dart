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
          int calamt() {
            if (snapshot.hasData) {
              int s = 0;
              for (int i = 0; i < snapshot.data!.docs.length; i++) {
                s += (snapshot.data!.docs[i].get("Price")) as int;
              }
              return s;
            }
            return 0;
          }

          int amt = calamt();
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
                          height: 450,
                          child: ListView.separated(
                              itemBuilder: (context, index) => Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                    color: Colors.black,
                                  )),
                                  height: 130,
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        width: 150,
                                        height: 90,
                                        child: Center(
                                            child: Image.asset(
                                                "assets/images/" +
                                                    snapshot.data!.docs[index]
                                                        .get("Image"))),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black)),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              snapshot.data!.docs[index]
                                                  .get("Name"),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20)),
                                          SizedBox(height: 5),
                                          Text(
                                            "Rs.${snapshot.data!.docs[index].get("Price")}",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          SizedBox(height: 10),
                                          TextButton.icon(
                                              icon: Icon(Icons.delete,
                                                  color: Colors.redAccent),
                                              onPressed: () {
                                                Dataservice(uid: user)
                                                    .removecart(snapshot
                                                        .data!.docs[index].id);
                                              },
                                              label: Text("Remove",
                                                  style: TextStyle(
                                                      color: Colors.redAccent)))
                                        ],
                                      )
                                    ],
                                  )),
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 10),
                              itemCount: snapshot.data!.docs.length),
                        ),
                        Container(
                          height: 50,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "  Total to Pay",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("Rs.${amt}  ",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold))
                                  ]),
                            ],
                          ),
                        )
                      ],
                    )
                  : Container());
        });
  }
}
