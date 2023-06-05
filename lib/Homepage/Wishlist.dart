import 'package:app/Providers/wishlist_provider.dart';
import 'package:app/services/Database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({Key? key}) : super(key: key);
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<String?>(context);
    return StreamBuilder<QuerySnapshot>(
        stream: Dataservice(uid: user!).wish,
        builder: (context, snapshot) {
          print(snapshot.data!.docs[0]);
          return (snapshot.hasData)
              ? Scaffold(
                  appBar: AppBar(
                    title: Text("Wishlist"),
                    elevation: 0,
                    titleTextStyle: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    backgroundColor: Colors.white,
                    centerTitle: true,
                  ),
                  body: ListView.separated(
                      itemBuilder: (context, index) => Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Colors.black,
                          )),
                          height: 130,
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                margin: EdgeInsets.all(10),
                                width: 150,
                                height: 90,
                                child: Center(
                                    child: Image.asset("assets/images/" +
                                        snapshot.data!.docs[index]
                                            .get("Image"))),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(snapshot.data!.docs[index].get("Name"),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                  SizedBox(height: 5),
                                  Text(
                                      "Rs.${snapshot.data!.docs[index].get("Price")}",
                                      style: TextStyle(fontSize: 15)),
                                  SizedBox(height: 10),
                                  TextButton.icon(
                                      icon: Icon(Icons.delete,
                                          color: Colors.redAccent),
                                      onPressed: () {
                                        Dataservice(uid: user).removewish(
                                            snapshot.data!.docs[index].id);
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
                )
              : Container();
        });
  }
}
